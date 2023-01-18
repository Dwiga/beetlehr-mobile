import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../payroll.dart';

class PayrollCard extends StatelessWidget {
  final PayrollEntity data;

  const PayrollCard({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp16),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: Dimens.dp16),
          Expanded(child: _buildCenter()),
          _buildRight(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp8),
      decoration: const BoxDecoration(
        color: StaticColors.green,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        AppIcons.walletLine,
        color: Colors.white,
        size: Dimens.dp24,
      ),
    );
  }

  Widget _buildCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(data.name),
        const SizedBox(height: Dimens.dp8),
        data.date != null
            ? RegularText(DateFormat('d MMM y').format(data.date!).toString())
            : const SizedBox(),
      ],
    );
  }

  Widget _buildRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (data.status == PayrollStatus.paid)
            ? Badge.success(text: 'PAID')
            : Badge.warning(
                text: PayrollStatusConverter.convertToString(data.status)
                        ?.toUpperCase() ??
                    '',
              ),
        const SizedBox(height: Dimens.dp8),
        SubTitle2Text(Utils.rupiahFormatter(data.totalAmount) ?? ''),
      ],
    );
  }
}
