import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class UserTile extends StatefulWidget {
  final Color? colorPlacement;
  final Color? colorDot;
  final Color? colorSubject;
  final Color? colorStatus;
  final Widget? additionalInfo;
  final Widget? avatarUser;
  final String? nameUser;
  final String? subjectUser;
  final String? placementUser;

  const UserTile({
    this.nameUser,
    this.subjectUser,
    this.placementUser,
    this.colorStatus,
    this.additionalInfo,
    this.avatarUser,
    this.colorDot,
    this.colorPlacement,
    this.colorSubject,
    Key? key,
  }) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CircleAvatar(
              radius: Dimens.dp18,
              backgroundColor: Colors.grey[300],
              child: widget.avatarUser),
        ),
        const SizedBox(width: Dimens.dp8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RegularText(
                        widget.nameUser ?? 'Sri Wardah Ratu Ningsih',
                        style: const TextStyle(
                            fontSize: Dimens.dp14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: Dimens.dp2),
                      Icon(
                        Icons.circle,
                        color: widget.colorStatus ?? StaticColors.lightGreen,
                        size: 8,
                      ),
                    ],
                  ),
                  if (widget.additionalInfo != null) ...[
                    widget.additionalInfo!,
                  ],
                ],
              ),
              const SizedBox(width: Dimens.dp2),
              Row(
                children: [
                  Text(
                    widget.subjectUser ?? 'Cleaning Service',
                    style: TextStyle(
                        color: widget.colorSubject ?? Colors.white,
                        fontSize: Dimens.dp12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(width: Dimens.dp2),
                  Icon(
                    Icons.circle,
                    color: widget.colorDot ?? StaticColors.lightGreen,
                    size: Dimens.dp4,
                  ),
                  const SizedBox(width: Dimens.dp2),
                  Text(
                    widget.placementUser ?? "Semarang",
                    style: TextStyle(
                        color: widget.colorPlacement ?? Colors.white,
                        fontSize: Dimens.dp12,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
