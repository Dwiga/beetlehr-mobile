import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../../notice.dart';

class UserInformatioSection extends StatelessWidget {
  final ApprovalRequestDetailEntity data;
  final int index;

  const UserInformatioSection(
      {Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: CircleAvatar(
                backgroundImage: NetworkImage(data
                        .approvers[index].approverImage!.isNotEmpty
                    ? data.approvers[index].approverImage.toString()
                    : "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Great_mosque_in_Medan_cropped.jpg/1200px-Great_mosque_in_Medan_cropped.jpg"),
                backgroundColor: Theme.of(context).disabledColor,
                onBackgroundImageError: (_, __) {},
                radius: 16,
              ),
            ),
            const SizedBox(width: Dimens.dp8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegularText(data.approvers[index].approverName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  SmallText(
                    data.approvers[index].designation,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.dp16),
        Expanded(
          child: data.approvers[index].reason!.isNotEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Dimens.dp16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimens.dp8),
                    ),
                    color: Color.fromARGB(145, 241, 241, 241),
                  ),
                  child: RegularText(data.approvers[index].reason.toString()),
                )
              : SizedBox(height: index == data.approvers.length - 1 ? 0 : 30),
        ),
        const SizedBox(height: Dimens.dp16),
      ],
    );
  }
}
