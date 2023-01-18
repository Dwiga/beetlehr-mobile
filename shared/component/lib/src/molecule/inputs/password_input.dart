import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import './inputs.dart';

class PasswordTextInput extends StatefulWidget {
  final String? hintText, errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? label;
  final bool? isRequired;
  final bool? readOnly;

  const PasswordTextInput(
      {Key? key,
      this.hintText,
      this.controller,
      this.focusNode,
      this.onChanged,
      this.errorText,
      this.label,
      this.isRequired,
      this.readOnly = false})
      : super(key: key);

  @override
  _PasswordTextInputState createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
        label: widget.label,
        isRequired: widget.isRequired,
        controller: widget.controller,
        focusNode: widget.focusNode,
        hintText: widget.hintText,
        onChange: widget.onChanged,
        errorText: widget.errorText,
        obscureText: _isObscure,
        suffix: _buildSuffix(),
        readOnly: widget.readOnly);
  }

  Widget _buildSuffix() {
    return InkWell(
      onTap: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
      child: Icon(_isObscure ? AppIcons.eyeHideLine : AppIcons.eyeLine),
    );
  }
}
