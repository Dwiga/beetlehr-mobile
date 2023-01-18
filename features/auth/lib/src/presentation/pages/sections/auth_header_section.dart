import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

/// Header section for Login, Verify, Reset Pass
class AuthHeaderSection extends StatelessWidget {
  /// Top icon header
  final IconData icon;

  /// Title of header
  final String title;

  /// Description text
  final String? description;

  /// Logo of the company
  final String? companyLogo;

  ///  Params [icon] and [title] can't be null
  const AuthHeaderSection(
      {Key? key,
      required this.icon,
      required this.title,
      this.description,
      this.companyLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 60),
        Image.asset(
          companyLogo.toString(),
          height: 150,
        ),
        const SizedBox(height: Dimens.dp14),
        Image.asset(
          'assets/images/beetlehr_text.png',
          height: Dimens.dp20,
        ),
        const SizedBox(height: Dimens.dp36),
        SubTitle1Text(
          title,
          align: TextAlign.center,
        ),
        const SizedBox(height: Dimens.dp8),
        description != null
            ? RegularText(
                description!,
                align: TextAlign.center,
              )
            : const SizedBox(),
      ],
    );
  }
}
