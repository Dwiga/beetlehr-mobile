import 'package:flutter/material.dart';

import '../../../component.dart';

class TextAreaInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final ValueChanged<String>? onChange, onSubmit;
  final String? label;
  final bool? isRequired;
  final int? minLine, maxLine;
  final bool? readOnly;

  const TextAreaInput({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChange,
    this.onSubmit,
    this.errorText,
    this.label,
    this.isRequired,
    this.minLine,
    this.maxLine,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
        controller: controller,
        focusNode: focusNode,
        hintText: hintText,
        errorText: errorText,
        inputType: TextInputType.multiline,
        inputAction: TextInputAction.newline,
        onChange: onChange,
        onSubmit: onSubmit,
        minLine: minLine ?? 4,
        maxLine: maxLine,
        readOnly: readOnly,
        label: label,
        isRequired: isRequired);
  }
}
