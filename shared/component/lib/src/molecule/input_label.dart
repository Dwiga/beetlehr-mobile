import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final bool? isRequired;

  const InputLabel({Key? key, required this.label, this.isRequired})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.dp4),
      child: RichText(
        text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.headline6,
            children: [
              TextSpan(
                  text: isRequired ?? false ? ' *' : '',
                  style: TextStyle(color: Theme.of(context).errorColor))
            ]),
      ),
    );
  }
}
