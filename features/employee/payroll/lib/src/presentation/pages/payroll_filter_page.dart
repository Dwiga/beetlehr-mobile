import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class PayrollFilterPage extends StatefulWidget {
  final Map<String, int?>? initialDate;

  const PayrollFilterPage({Key? key, this.initialDate}) : super(key: key);
  @override
  _PayrollFilterPageState createState() => _PayrollFilterPageState();
}

class _PayrollFilterPageState extends State<PayrollFilterPage> {
  final List<String> _monthData = [];
  final List<String> _yearData = [];

  String? _initialMonth;
  String? _initialYear;

  @override
  void initState() {
    _initMonth();
    _initYear();
    _changeInitial();
    super.initState();
  }

  void _initMonth() {
    for (var i = 0; i < 12; i++) {
      _monthData.add(
        DateFormat('MMMM').format(
          DateTime(
            DateTime.now().year,
            i + 1,
          ),
        ),
      );
    }
  }

  void _initYear() {
    for (var i = 0; i < 6; i++) {
      _yearData.add(
        DateFormat('y').format(
          DateTime(
            DateTime.now().year - i,
            1,
          ),
        ),
      );
    }
  }

  void _changeInitial() {
    if (widget.initialDate != null) {
      if (widget.initialDate?['year'] != null &&
          _yearData.contains(widget.initialDate?['year']?.toString())) {
        _initialYear = widget.initialDate?['year']?.toString();
      }

      if (widget.initialDate?['month'] != null &&
          widget.initialDate?['month'] is int) {
        _initialMonth = _monthData[(widget.initialDate!['month'] ?? 0) - 1];
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter')),
      body: _buildBody(),
      bottomNavigationBar: _buildApplyButton(),
    );
  }

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      children: [
        DropdownInput(
            onChange: (v) {
              setState(() {
                _initialMonth = v;
              });
            },
            initialValue: _initialMonth,
            label: S.of(context).select_month,
            withSearchBar: true,
            data: _monthData),
        const SizedBox(height: Dimens.dp16),
        DropdownInput(
          onChange: (v) {
            setState(() {
              _initialYear = v;
            });
          },
          initialValue: _initialYear,
          label: S.of(context).select_year,
          withSearchBar: true,
          data: _yearData,
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SafeArea(
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(Dimens.dp16),
        child: PrimaryButton(
          onPressed: (_initialMonth != null || _initialYear != null)
              ? () async {
                  var _year = Utils.intParser(_initialYear);
                  var _month = _monthData.contains(_initialMonth);
                  if (_year != null || _month) {
                    final _dataCallback = <String, int?>{
                      'year': _year ?? 0,
                      'month': _month
                          ? _monthData.indexOf(_initialMonth!) + 1
                          : null,
                    };
                    Navigator.of(context).pop(_dataCallback);
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              : null,
          child: Text(S.of(context).apply),
        ),
      ),
    );
  }
}
