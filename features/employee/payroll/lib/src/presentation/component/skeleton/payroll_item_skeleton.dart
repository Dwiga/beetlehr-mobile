import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class PayrollItemSkeleton extends StatelessWidget {
  const PayrollItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Skeleton(
            width: Dimens.dp32,
            height: Dimens.dp32,
            radius: Dimens.dp16,
          ),
          SizedBox(width: Dimens.dp16),
          Expanded(
            child: Skeleton(
              width: null,
              height: Dimens.dp16,
            ),
          ),
        ],
      ),
    );
  }
}
