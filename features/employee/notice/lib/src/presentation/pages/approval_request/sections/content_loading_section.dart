import 'package:flutter/material.dart';
import 'all_approval_item_skeleton_section.dart';

class ContentLoading extends StatelessWidget {
  const ContentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemBuilder: (_, __) {
        return const AllApprovalItemSkeleton();
      },
      itemCount: 3,
      separatorBuilder: (_, __) {
        return const Divider(height: 1);
      },
    );
  }
}
