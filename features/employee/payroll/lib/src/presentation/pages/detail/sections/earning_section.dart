import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../../payroll.dart';

class EarningSection extends StatelessWidget {
  final PayrollDetailEntity data;
  const EarningSection({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubTitle2Text('Earning'),
          const SizedBox(height: Dimens.dp16),
          _buildComponent(),
          const Divider(),
          const SizedBox(height: Dimens.dp8),
          Row(
            children: [
              const Expanded(child: SubTitle2Text('Total Earning')),
              SubTitle2Text(Utils.rupiahFormatter(data.totalEarning) ?? '')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComponent() {
    return Column(
      children: data.earnings.map(_buildItemComponent).toList(),
    );
  }

  Widget _buildItemComponent(PayrollComponentEntity data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp8),
      child: Row(
        children: [
          Expanded(child: Text(data.name)),
          Text(Utils.rupiahFormatter(data.amount) ?? '')
        ],
      ),
    );
  }
}
