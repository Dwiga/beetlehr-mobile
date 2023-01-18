import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class NeedApprovalCard extends StatelessWidget {
  final int count;
  final String title;
  final VoidCallback? onTap;

  const NeedApprovalCard({
    Key? key,
    required this.count,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          const Expanded(child: SubTitle2Text('Reimbusment')),
          SubTitle2Text(
            '$count',
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
        ],
      ),
      leading: _buildIcon(context, AppIcons.clockLine, StaticColors.green),
      trailing: const Icon(
        Icons.chevron_right,
        size: Dimens.dp24,
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, [Color? color]) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp10),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).disabledColor,
          shape: BoxShape.circle),
      child: Icon(icon, size: Dimens.dp22, color: Colors.white),
    );
  }
}
