import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../notice.dart';
import 'sections.dart';

class FilterDialogPage extends StatefulWidget {
  final String? sortByValue;
  final ApprovalTimeRangeEntity? time;
  final int? totalItemFilter;

  const FilterDialogPage({
    Key? key,
    this.sortByValue,
    this.time,
    this.totalItemFilter,
  }) : super(key: key);

  @override
  _FilterDialogPageState createState() => _FilterDialogPageState();
}

class _FilterDialogPageState extends State<FilterDialogPage> {
  String? _sortByValue;
  final List<bool> _totalItemFilter = List<bool>.empty(growable: true);
  ApprovalTimeRangeEntity? _approvalTimeRange;

  @override
  void initState() {
    _sortByValue = widget.sortByValue;
    _approvalTimeRange = widget.time;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 80,
                height: Dimens.dp4,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: Dimens.dp16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
              child: Row(
                children: [
                  Text(
                    S.of(context).filters,
                    style: const TextStyle(
                        fontSize: Dimens.dp14, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: widget.totalItemFilter! > 0
                        ? () {
                            const value = ApprovalRequestFilterEntity(
                                sortBy: "",
                                startTime: "",
                                endTime: "",
                                totalItemFilter: 0);

                            Navigator.of(context).pop(value);
                          }
                        : null,
                    child: Text(
                      S.of(context).reset_all,
                      style: TextStyle(
                          color: widget.totalItemFilter! > 0
                              ? MaterialLightTheme.primaryColor
                              : Colors.grey[350]),
                    ),
                  ),
                ],
              ),
            ),
            const DividerSection(),
            const DividerSection(),
            TimeRangeSection(
              time: _approvalTimeRange,
              onChange: (value) {
                setState(
                  () {
                    _approvalTimeRange = value;
                  },
                );
              },
            ),
            const SizedBox(
              height: Dimens.dp16,
            ),
            const DividerSection(),
            SortingSection(
              valueSelected: _sortByValue,
              onChange: (value) {
                setState(
                  () {
                    _sortByValue = value;
                  },
                );
              },
            ),
            const DividerSection(),
            _actionButtonFilter()
          ],
        ),
      ),
    );
  }

  void collectTotalItem() {
    if (_approvalTimeRange?.startTime?.isNotEmpty == true &&
        _approvalTimeRange?.endTime?.isNotEmpty == true) {
      _totalItemFilter.add(true);
    } else {
      _totalItemFilter.add(false);
    }

    if (_sortByValue?.isNotEmpty == true) {
      _totalItemFilter.add(true);
    } else {
      _totalItemFilter.add(false);
    }
  }

  Widget _actionButtonFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp16, vertical: Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
            onPressed: _approvalTimeRange?.startTime?.isNotEmpty == true ||
                    _sortByValue?.isNotEmpty == true
                ? () {
                    setState(() {
                      collectTotalItem();
                    });

                    final value = ApprovalRequestFilterEntity(
                        sortBy: _sortByValue,
                        startTime: _approvalTimeRange?.startTime ?? '',
                        endTime: _approvalTimeRange?.endTime ?? '',
                        totalItemFilter: _totalItemFilter
                            .where((element) => element == true)
                            .length);

                    Navigator.of(context).pop(value);
                  }
                : null,
            child: Text(S.of(context).apply),
          ),
        ],
      ),
    );
  }
}
