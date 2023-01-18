import 'package:flutter/material.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey[200],
      thickness: 1,
      height: 0.5,
    );
  }
}
