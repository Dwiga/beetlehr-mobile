import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../atom/atom.dart';

class ListMenuTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color leadingColor;
  final IconData leadingIcon;
  final Widget? trailing;
  const ListMenuTile({
    Key? key,
    required this.title,
    this.onTap,
    required this.leadingColor,
    required this.leadingIcon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: trailing,
      shape: Theme.of(context).cardTheme.shape,
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        width: Dimens.dp48,
        height: Dimens.dp48,
        padding: const EdgeInsets.all(Dimens.dp8),
        decoration: BoxDecoration(
          color: leadingColor,
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
        child: Icon(
          leadingIcon,
          size: Dimens.dp24,
          color: Colors.white,
        ),
      ),
      title: SubTitle2Text(title),
    );
  }
}
