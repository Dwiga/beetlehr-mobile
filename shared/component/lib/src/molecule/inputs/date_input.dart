import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class DateInput extends StatefulWidget {
  final String? label;
  final DateTime? value;
  final DateTime startDate;
  final DateTime endDate;
  final ValueChanged<DateTime> onChange;
  final String formatDate;
  final String? errorText;
  final bool? isRequired;
  final bool? readOnly;
  const DateInput({
    Key? key,
    this.label,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.onChange,
    this.formatDate = 'd-MM-y',
    this.errorText,
    this.isRequired,
    this.readOnly,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _setDateFormatter();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DateInput oldWidget) {
    _setDateFormatter();
    super.didUpdateWidget(oldWidget);
  }

  void _setDateFormatter() {
    if (widget.value != null) {
      _controller.text = DateFormat(widget.formatDate).format(widget.value!);
    } else {
      _controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      readOnly: true,
      label: widget.label,
      isRequired: widget.isRequired,
      controller: widget.value != null ? _controller : null,
      onTap: () {
        if (widget.readOnly != true) {
          _showDatePicker(context);
        }
      },
      suffix: const Icon(AppIcons.calendarLine),
      errorText: widget.errorText,
    );
  }

  void _showDatePicker(BuildContext context) async {
    final result = await showDatePicker(
      context: context,
      initialDate: widget.value ?? widget.startDate,
      firstDate: widget.startDate,
      lastDate: widget.endDate,
    );

    if (result is DateTime) {
      widget.onChange(result);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
