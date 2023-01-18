import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class AppAlertDialog extends StatelessWidget {
  final Widget body;
  final List<Widget>? actions;
  const AppAlertDialog({
    Key? key,
    required this.body,
    this.actions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
            button: TextStyle(
                fontSize: Dimens.dp12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
      ),
      child: AlertDialog(
        content: body,
        actions: actions,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp10)),
        contentTextStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
