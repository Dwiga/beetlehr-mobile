import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../../payroll.dart';

class ResignPinaltySection extends StatelessWidget {
  final PayrollDetailEntity data;
  const ResignPinaltySection({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (data.resignPinaltyAmount == null) return const SizedBox();
    return Column(
      children: [
        Container(
          height: Dimens.dp24,
          width: double.infinity,
          color: Theme.of(context).disabledColor.withOpacity(0.1),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Row(
            children: [
              const Expanded(child: SubTitle2Text('Resign Penalties')),
              SubTitle2Text(
                  Utils.rupiahFormatter(data.resignPinaltyAmount) ?? '')
            ],
          ),
        ),
      ],
    );
  }
}
