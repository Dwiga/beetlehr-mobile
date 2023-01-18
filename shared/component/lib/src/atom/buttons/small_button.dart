import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class SmallButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;

  const SmallButton(
      {Key? key, required this.onPressed, this.color, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme: const TextTheme(
        button: TextStyle(
          fontSize: Dimens.dp12,
          fontWeight: FontWeight.normal,
        ),
      )),
      child: MaterialButton(
        onPressed: onPressed,
        child: child,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp4, horizontal: Dimens.dp22),
        color: color ?? Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(Dimens.dp4)),
        elevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
      ),
    );
  }
}
