import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class CircleMenuCard extends StatelessWidget {
  final Color color;
  final bool isOutline;
  final String label;
  final String value;

  const CircleMenuCard({
    Key? key,
    required this.color,
    this.isOutline = false,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimens.dp48,
          height: Dimens.dp48,
          decoration: _getDecoration(),
          child: _buildValue(),
        ),
        const SizedBox(height: Dimens.dp8),
        RegularText(
          label,
          maxLine: 2,
          align: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildValue() {
    return Center(
      child: SubTitle1Text(
        value,
        style: TextStyle(color: isOutline ? color : Colors.white),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    if (isOutline) {
      return BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: Dimens.dp2,
          color: color,
        ),
      );
    }
    return BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    );
  }
}
