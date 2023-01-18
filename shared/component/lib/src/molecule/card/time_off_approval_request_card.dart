import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class TimeOffApprovalRequestCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String cratedAt;
  final String status;
  final String statusLabel;
  final String startTime;
  final String endTime;
  final String duration;
  final String type;
  final String typeLabel;

  const TimeOffApprovalRequestCard(
      {Key? key,
      this.imageUrl,
      required this.name,
      required this.cratedAt,
      required this.status,
      required this.statusLabel,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.type,
      required this.typeLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl ??
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Great_mosque_in_Medan_cropped.jpg/1200px-Great_mosque_in_Medan_cropped.jpg"),
              backgroundColor: Theme.of(context).disabledColor,
              onBackgroundImageError: (_, __) {},
              radius: 24,
            ),
            const SizedBox(width: Dimens.dp8),
            _buildUserInfo(),
            const SizedBox(width: Dimens.dp8),
            if (status == "awaiting") ...[
              _buildApprovalStatusInfo(
                  Colors.orange, statusLabel, Icons.access_time)
            ] else if (status == "approved") ...[
              _buildApprovalStatusInfo(Colors.green, statusLabel, Icons.check)
            ] else if (status == "rejected") ...[
              _buildApprovalStatusInfo(Colors.red, statusLabel, Icons.close)
            ] else ...[
              _buildApprovalStatusInfo(
                  Colors.purple, statusLabel, Icons.block_sharp)
            ]
          ],
        ),
        if (type == "time_off") ...[
          const SizedBox(height: Dimens.dp16),
          _buildTimeOffDurationInfo(context)
        ]
      ],
    );
  }

  Widget _buildTimeOffDurationInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.dp4)),
        color: Color.fromARGB(145, 241, 241, 241),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RegularText(
                  "Time Off Duration :",
                  style: TextStyle(color: Colors.grey, fontSize: Dimens.dp12),
                ),
                const SizedBox(height: Dimens.dp6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: RegularText(
                        startTime,
                        style: const TextStyle(fontSize: Dimens.dp12),
                      ),
                    ),
                    const SizedBox(width: Dimens.dp12),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.grey,
                      size: Dimens.dp12,
                    ),
                    const SizedBox(width: Dimens.dp12),
                    Expanded(
                      child: RegularText(
                        endTime,
                        style: const TextStyle(fontSize: Dimens.dp12),
                      ),
                    ),
                    const SizedBox(width: Dimens.dp20),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RegularText(
              duration,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalStatusInfo(
      Color color, String approvalStatus, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp16, vertical: Dimens.dp8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.dp16)),
        color: color,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: Dimens.dp16,
          ),
          const SizedBox(width: Dimens.dp8),
          RegularText(
            approvalStatus,
            style: const TextStyle(color: Colors.white, fontSize: Dimens.dp12),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: RegularText(
                  name,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.dp2, horizontal: Dimens.dp8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dp2),
                  ),
                  color: Color.fromARGB(155, 253, 223, 177),
                ),
                child: RegularText(
                  typeLabel,
                  style: const TextStyle(
                      color: Colors.orange, fontSize: Dimens.dp12),
                ),
              ),
            ],
          ),
          RegularText(
            cratedAt,
            style: const TextStyle(color: Colors.grey, fontSize: Dimens.dp12),
          ),
        ],
      ),
    );
  }
}
