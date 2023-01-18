import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;

  const PrimaryButton(
      {Key? key, required this.onPressed, this.color, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: child,
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.dp14, horizontal: Dimens.dp32),
      color: color ?? Theme.of(context).primaryColor,
      disabledColor: (color ?? Theme.of(context).primaryColor).withOpacity(0.7),
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(Dimens.dp10)),
      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
    );
  }
}
