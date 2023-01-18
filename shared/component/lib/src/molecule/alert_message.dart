import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class AlertMessage extends StatelessWidget {
  final Color? backgroundColor;
  final Widget message;
  final Color? iconColor;
  final IconData? icon;
  const AlertMessage({
    Key? key,
    this.backgroundColor,
    required this.message,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  factory AlertMessage.success(Widget message, {IconData? icon}) {
    return AlertMessage(
      message: message,
      backgroundColor: StaticColors.green.withOpacity(0.5),
      icon: icon,
      iconColor: Colors.black,
    );
  }

  factory AlertMessage.primary(Widget message, {IconData? icon}) {
    return AlertMessage(
      message: message,
      backgroundColor: const Color(0xFF4285F4),
      icon: icon,
      iconColor: Colors.white,
    );
  }

  factory AlertMessage.danger(Widget message, {IconData? icon}) {
    return AlertMessage(
      message: message,
      backgroundColor: StaticColors.red.withOpacity(0.5),
      icon: icon,
      iconColor: StaticColors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp10),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: message,
          ),
          Icon(
            icon,
            size: Dimens.dp24,
            color: iconColor,
          )
        ],
      ),
    );
  }
}
