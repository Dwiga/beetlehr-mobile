import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../../payroll.dart';

class HeaderSection extends StatelessWidget {
  final PayrollDetailEntity data;
  const HeaderSection({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.dp16,
        80,
        Dimens.dp16,
        Dimens.dp16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data.image ?? ''),
            radius: 24,
            backgroundColor: Theme.of(context).disabledColor,
          ),
          const SizedBox(width: Dimens.dp16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SubTitle2Text(
                  data.name,
                ),
                const SizedBox(height: Dimens.dp8),
                Text(
                  data.designation,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatus(),
              const SizedBox(height: Dimens.dp8),
              Text(
                'Paid on: ${_getPayrollDate()}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    if (data.status == PayrollStatus.paid) {
      return Badge.success(text: 'PAID');
    }
    return Badge.warning(
        text: PayrollStatusConverter.convertToString(data.status) ?? '');
  }

  String _getPayrollDate() {
    return data.paidOn != null
        ? DateFormat('d, MMM y').format(data.paidOn!)
        : '';
  }
}
