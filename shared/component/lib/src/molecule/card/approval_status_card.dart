import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class ApprovalStatusCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String cratedAt;
  final String status;
  final String startTime;
  final String endTime;
  final String duration;
  final VoidCallback? onTap;

  const ApprovalStatusCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.cratedAt,
      required this.status,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegularText(
            "Pending",
            style: TextStyle(color: Colors.grey, backgroundColor: Colors.amber),
          ),
          const SizedBox(width: Dimens.dp16),
          Column(children: [
            Container(
              padding: const EdgeInsets.all(Dimens.dp4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color.fromARGB(195, 251, 212, 154),
              ),
              child: const Icon(
                Icons.replay_circle_filled_rounded,
                color: Colors.white,
                size: Dimens.dp24,
              ),
            ),
          ]),
          const SizedBox(width: Dimens.dp16),
          _buildUserInfo(context)
        ],
      ),
      const SizedBox(height: Dimens.dp16),
    ]);
  }

  Widget _buildUserInfo(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
              child: CircleAvatar(
            backgroundImage: const NetworkImage("imageUrl"),
            backgroundColor: Theme.of(context).disabledColor,
            onBackgroundImageError: (_, __) {},
            radius: 24,
          )),
          const SizedBox(width: Dimens.dp8),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                RegularText(name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                const RegularText(
                  "Lead Enginer",
                  style: TextStyle(color: Colors.grey),
                ),
              ])),
        ]),
        Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(Dimens.dp16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.dp16)),
                color: Color.fromARGB(145, 241, 241, 241),
              ),
              child: const Expanded(
                child: RegularText(
                  "Cuti ini cuti bersama dengan teman-teman",
                ),
              ),
            )),
          ],
        ),
      ],
    ));
  }
}
