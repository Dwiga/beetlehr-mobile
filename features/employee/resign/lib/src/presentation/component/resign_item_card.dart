import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../resign.dart';

class ResignItemCard extends StatelessWidget {
  final ResignEntity data;

  const ResignItemCard({Key? key, required this.data}) : super(key: key);
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
        color: StaticColors.indigo,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        AppIcons.employeeLine,
        color: Colors.white,
        size: Dimens.dp24,
      ),
    );
  }

  Widget _buildCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(data.label),
        const SizedBox(height: Dimens.dp8),
        RegularText(data.date),
      ],
    );
  }

  Widget _buildRight() {
    return (data.status == ResignStatus.approved)
        ? Badge.success(text: 'APPROVED')
        : Badge.warning(
            text: ResignStatusConverter.convertToString(data.status)
                    ?.toUpperCase() ??
                '',
          );
  }
}
