import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../profile.dart';

class AboutProfileCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final ProfileEntity user;

  const AboutProfileCard({Key? key, this.onPressed, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildImageAvatar(context),
            const SizedBox(
              width: Dimens.dp16,
            ),
            Expanded(child: _buildInfoBody()),
            _buildAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.image ??
              'https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png'),
          radius: 40,
          backgroundColor: Theme.of(context).disabledColor,
        ),
        Container(
          width: Dimens.dp24,
          height: Dimens.dp24,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight),
          alignment: Alignment.center,
          child: const Icon(Icons.add_a_photo,
              color: Colors.white, size: Dimens.dp12),
        ),
      ],
    );
  }

  Widget _buildInfoBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RegularText(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // SizedBox(height: Dimens.dp2),
        // RegularText('Software Engineer'),
        // SizedBox(height: Dimens.dp2),
        // RegularText('Product Management'),
        const SizedBox(height: Dimens.dp2),
        RegularText(user.designation ?? ''),
        const SizedBox(height: Dimens.dp2),
        RegularText(user.email),
      ],
    );
  }

  Widget _buildAction(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.chevron_right,
          size: Dimens.dp24, color: Theme.of(context).disabledColor),
    );
  }
}
