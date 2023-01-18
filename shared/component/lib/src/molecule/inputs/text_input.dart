import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class RegularTextInput extends StatelessWidget {
  const RegularTextInput({
    Key? key,
    this.obscureText = false,
    this.focusNode,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.controller,
    this.background,
    this.radius,
    this.errorText,
    this.minLine = 1,
    this.maxLine = 1,
    this.onChange,
    this.onSubmit,
    this.inputAction,
    this.style,
    this.inputType,
    this.border,
    this.enable = true,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.maxLength,
    this.autoFocus,
    this.label,
    this.isRequired,
  }) : super(key: key);

  final Widget? prefixIcon;
  final bool? obscureText, enable, readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final Widget? suffix;
  final Color? background;
  final double? radius;
  final int? minLine, maxLine;
  final ValueChanged<String>? onChange, onSubmit;
  final TextInputAction? inputAction;
  final TextStyle? style;
  final TextInputType? inputType;
  final InputBorder? border;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? autoFocus;
  final String? label;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? _buildLabel() : const SizedBox(),
        Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              size: Dimens.dp10,
            ),
            primaryColor: Theme.of(context).textTheme.headline5?.color,
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            minLines: minLine,
            maxLines: maxLine,
            maxLength: maxLength,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            textInputAction: inputAction ?? TextInputAction.done,
            style: style,
            keyboardType: inputType,
            enabled: enable,
            onTap: onTap,
            readOnly: readOnly ?? false,
            inputFormatters: inputFormatters,
            autofocus: autoFocus ?? false,
            decoration: InputDecoration(
              errorText: errorText,
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: Dimens.dp6,
                horizontal: Dimens.dp12,
              ),
              hintText: hintText ?? '',
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
                borderRadius: BorderRadius.circular(Dimens.dp4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                ),
                borderRadius: BorderRadius.circular(Dimens.dp8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Dimens.dp8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Dimens.dp8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Dimens.dp8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel() {
    if (label != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: Dimens.dp8),
        child: InputLabel(
          label: label ?? '',
          isRequired: isRequired,
        ),
      );
    }
    return const SizedBox();
  }
}
