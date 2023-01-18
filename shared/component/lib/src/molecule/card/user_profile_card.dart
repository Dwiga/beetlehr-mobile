import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class UserProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  const UserProfileCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp14, horizontal: Dimens.dp16),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Theme.of(context).disabledColor,
          onBackgroundImageError: (_, __) {},
          radius: 30,
        ),
        const SizedBox(width: Dimens.dp8),
        _buildUserInfo(context),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
          text: '${S.of(context).hello}, ',
          children: [
            TextSpan(
                text: name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.normal),
        )),
        RegularText(email),
      ],
    ));
  }
}
