import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../../notice.dart';

class HeaderInformationSection extends StatelessWidget {
  final ApprovalRequestDetailEntity data;

  const HeaderInformationSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(data.requesterImage!.isNotEmpty
              ? data.requesterImage.toString()
              : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Great_mosque_in_Medan_cropped.jpg/1200px-Great_mosque_in_Medan_cropped.jpg'),
          backgroundColor: Theme.of(context).disabledColor,
          onBackgroundImageError: (_, __) {},
          radius: 18,
        ),
        const SizedBox(width: Dimens.dp8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegularText(
                data.requesterName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RegularText(
                "${data.requesterDesignation} - ${data.requesterPlacment}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.dp16, vertical: Dimens.dp8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.dp16),
            ),
            color: getColor(data),
          ),
          child: Row(children: [
            getIcon(data),
            const SizedBox(width: Dimens.dp8),
            RegularText(
              data.statusLabel,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ]),
        ),
      ],
    );
  }

  Widget getIcon(ApprovalRequestDetailEntity data) {
    if (data.status == ApprovalRequestType.awaiting) {
      return const Icon(
        Icons.access_time,
        size: Dimens.dp16,
        color: Colors.white,
      );
    } else if (data.status == ApprovalRequestType.approved) {
      return const Icon(Icons.check, size: Dimens.dp16, color: Colors.white);
    } else if (data.status == ApprovalRequestType.rejected) {
      return const Icon(
        Icons.close,
        size: Dimens.dp16,
        color: Colors.white,
      );
    } else {
      return const Icon(
        Icons.block_sharp,
        size: Dimens.dp16,
        color: Colors.white,
      );
    }
  }

  Color getColor(ApprovalRequestDetailEntity data) {
    if (data.status == ApprovalRequestType.awaiting) {
      return Colors.orange;
    } else if (data.status == ApprovalRequestType.rejected) {
      return Colors.red;
    } else if (data.status == ApprovalRequestType.approved) {
      return Colors.green;
    } else {
      return Colors.purple;
    }
  }
}
