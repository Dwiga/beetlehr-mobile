import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../component.dart';

class ErrorMessageWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String? message;
  const ErrorMessageWidget({
    Key? key,
    required this.onPress,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RegularText(
            message ?? 'Sepertinya sedang terjadi suatu masalah...',
            align: TextAlign.center,
          ),
          const SizedBox(height: Dimens.dp16),
          PrimaryButton(
            child: Text(S.of(context).reload),
            onPressed: onPress,
          ),
        ],
      ),
    );
  }
}
