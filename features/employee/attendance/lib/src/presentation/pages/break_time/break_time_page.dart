import 'package:flutter/material.dart';
import '../break_page.dart';

class BreakTimePage extends StatefulWidget {
  const BreakTimePage({
    Key? key,
    this.startBreakTime,
  }) : super(key: key);

  final String? startBreakTime;

  @override
  _BreakTimePageState createState() => _BreakTimePageState();
}

class _BreakTimePageState extends State<BreakTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: BreakPage(startBreakTime: widget.startBreakTime),
      ),
    );
  }
}
