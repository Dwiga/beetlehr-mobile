import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class AllApprovalItemSkeleton extends StatelessWidget {
  const AllApprovalItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp16, vertical: Dimens.dp16),
      title: Container(
        height: Dimens.dp16,
        padding: EdgeInsets.only(right: Dimens.width(context) * .1),
        child: const Skeleton(),
      ),
      subtitle: Container(
        height: Dimens.dp14,
        padding: EdgeInsets.only(right: Dimens.width(context) * .4),
        child: const Skeleton(),
      ),
      trailing: const Skeleton(
        height: Dimens.dp24,
        width: Dimens.dp24,
      ),
    );
  }
}
