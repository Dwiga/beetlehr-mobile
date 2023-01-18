import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final Color? bgColor;

  const Badge({Key? key, this.bgColor, required this.child}) : super(key: key);

  factory Badge.success({required String text}) {
    return Badge(
      bgColor: StaticColors.green,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimens.dp10,
          color: Colors.white,
        ),
      ),
    );
  }

  factory Badge.warning({required String text}) {
    return Badge(
      bgColor: StaticColors.yellow,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimens.dp10,
        ),
      ),
    );
  }

  factory Badge.error({required String text}) {
    return Badge(
      bgColor: StaticColors.red,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimens.dp10,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Dimens.dp10),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.dp4, horizontal: Dimens.dp8),
      child: child,
    );
  }
}
