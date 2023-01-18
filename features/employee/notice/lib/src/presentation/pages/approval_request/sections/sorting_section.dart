import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/src/presentation/pages/approval_request/sections/sections.dart';
import 'package:preferences/preferences.dart';

class SortingSection extends StatefulWidget {
  final ValueChanged<String>? onChange;
  final String? valueSelected;

  const SortingSection({Key? key, this.onChange, this.valueSelected})
      : super(key: key);

  @override
  _SortingSectionState createState() => _SortingSectionState();
}

class _SortingSectionState extends State<SortingSection> {
  int? _value = 0;
  String? _sortByValue;

  @override
  void initState() {
    getSortBy(widget.valueSelected.toString());

    super.initState();
  }

  void getSortBy(String sortBy) {
    setState(() {
      if (sortBy == "desc") {
        _value = 1;
      } else if (sortBy == "asc") {
        _value = 2;
      } else {
        _value = 0;
      }
    });
  }

  String getSortByValue(int sortBy) {
    if (sortBy == 1) {
      _sortByValue = "desc";
    } else if (sortBy == 2) {
      _sortByValue = "asc";
    } else {
      _sortByValue = "";
    }
    return _sortByValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              RegularText(
                S.of(context).sort_by,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _value = 0;
                    widget.onChange!(getSortByValue(_value!));
                  });
                },
                child: Text(
                  S.of(context).clear,
                  style: const TextStyle(
                      color: MaterialLightTheme.primaryColor, fontSize: 14),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(
                S.of(context).new_first,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Radio(
                value: 1,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value as int?;
                    widget.onChange!(getSortByValue(_value!));
                  });
                },
              )
            ],
          ),
          const DividerSection(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularText(
                S.of(context).old_first,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Radio(
                value: 2,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value as int?;
                    widget.onChange!(getSortByValue(_value!));
                  });
                },
              )
            ],
          ),
          // const DividerSection(),
        ],
      ),
    );
  }
}
