import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:l10n/l10n.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            GetIt.I<GlobalConfiguration>().getValue('company_logo'),
            width: Dimens.width(context) / 2.4,
            height: Dimens.width(context) / 2.4,
          ),
          const SizedBox(height: Dimens.dp12, width: double.infinity),
          const CircularProgressIndicator(),
          const SizedBox(height: Dimens.dp24),
          Text('${S.of(context).please_wait}....'),
        ],
      ),
    );
  }
}
