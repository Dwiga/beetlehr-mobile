import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

/// Horizontal Line
///
/// Divider for alternative login
class HorizontalLineSection extends StatelessWidget {
  /// Text in center of divider(Horizontal line)
  final String text;

  ///
  const HorizontalLineSection({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        const SizedBox(width: Dimens.dp16),
        SubTitle1Text(
          text,
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        const SizedBox(width: Dimens.dp16),
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
