import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/notice.dart';
import 'package:preferences/preferences.dart';

class TimeRangeSection extends StatefulWidget {
  final ValueChanged<ApprovalTimeRangeEntity>? onChange;
  final ApprovalTimeRangeEntity? time;

  const TimeRangeSection({Key? key, this.onChange, this.time})
      : super(key: key);

  @override
  _TimeRangeSectionState createState() => _TimeRangeSectionState();
}

class _TimeRangeSectionState extends State<TimeRangeSection> {
  String _startDate = "";
  String _endDate = "";
  String _startDateLabel = "";
  String _endDateLabel = "";

  @override
  void initState() {
    _startDate = widget.time?.startTime ?? "";
    _endDate = widget.time?.endTime ?? "";
    if (_startDate.isNotEmpty) {
      _startDateLabel = formateDate(widget.time!.startTime.toString());
    } else {
      _startDateLabel = "";
    }
    if (_endDate.isNotEmpty) {
      _endDateLabel = formateDate(widget.time!.endTime.toString());
    } else {
      _endDateLabel = "";
    }
    super.initState();
  }

  String formateDate(String? dateTime) {
    if (dateTime != null || dateTime!.isNotEmpty) {
      var inputFormat = DateFormat('y-MM-dd');
      var inputDate = inputFormat.parse(dateTime.toString());
      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(inputDate);

      return outputDate;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
      child: Column(
        children: [
          Row(
            children: [
              RegularText(
                S.of(context).time_range,
                style:
                    const TextStyle(color: Colors.grey, fontSize: Dimens.dp14),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      _startDateLabel = "";
                      _endDateLabel = "";
                      _startDate = "";
                      _endDate = "";
                      widget.onChange!(
                        const ApprovalTimeRangeEntity(
                            startTime: "", endTime: ""),
                      );
                    },
                  );
                },
                child: Text(
                  S.of(context).clear,
                  style: const TextStyle(
                      color: MaterialLightTheme.primaryColor,
                      fontSize: Dimens.dp14),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dp12),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.dp10),
              border: Border.all(color: Colors.grey[350]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: RegularText(
                        _startDateLabel.isNotEmpty
                            ? _startDateLabel
                            : DateFormat('dd/MM/yyyy').format(
                                DateTime.now(),
                              ),
                        style: _startDateLabel.isNotEmpty
                            ? const TextStyle()
                            : const TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        _openDatePickerSheet();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.dp10),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: Dimens.dp16,
                ),
                const SizedBox(width: Dimens.dp10),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: RegularText(
                        _endDateLabel.isNotEmpty
                            ? _endDateLabel
                            : DateFormat('dd/MM/yyyy').format(
                                DateTime.now().add(
                                  const Duration(days: 1),
                                ),
                              ),
                        style: _endDateLabel.isNotEmpty
                            ? const TextStyle()
                            : const TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        _openDatePickerSheet();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.dp20),
                IconButton(
                  padding: const EdgeInsets.all(Dimens.dp2),
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                    size: Dimens.dp16,
                  ),
                  onPressed: () {
                    _openDatePickerSheet();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(
      () {
        if (args.value is PickerDateRange) {
          _startDateLabel =
              DateFormat('dd/MM/yyyy').format(args.value.startDate);
          _endDateLabel = DateFormat('dd/MM/yyyy')
              .format(args.value.endDate ?? args.value.startDate);
          _startDate = DateFormat('y-MM-dd').format(args.value.startDate);
          _endDate = DateFormat('y-MM-dd')
              .format(args.value.endDate ?? args.value.startDate);
          widget.onChange!(
            ApprovalTimeRangeEntity(startTime: _startDate, endTime: _endDate),
          );
        }
      },
    );
  }

  void _openDatePickerSheet() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              initialSelectedRange: PickerDateRange(
                _startDateLabel.isNotEmpty
                    ? DateFormat("dd/MM/yyyy").parse(_startDateLabel.toString())
                    : DateTime.now().subtract(
                        const Duration(days: 0),
                      ),
                _endDateLabel.isNotEmpty
                    ? DateFormat("dd/MM/yyyy").parse(_endDateLabel.toString())
                    : DateTime.now().add(
                        const Duration(days: 1),
                      ),
              ),
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
          contentPadding: const EdgeInsets.all(Dimens.dp8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp4),
          ),
        );
      },
    );
  }
}
