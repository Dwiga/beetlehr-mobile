import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../sections/sections.dart';

/// Login with WhatsApp
class LoginWithWhatsAppPage extends StatefulWidget {
  const LoginWithWhatsAppPage({Key? key}) : super(key: key);

  @override
  _LoginWithWhatsAppPageState createState() => _LoginWithWhatsAppPageState();
}

class _LoginWithWhatsAppPageState extends State<LoginWithWhatsAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).login),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
        children: [
          AuthHeaderSection(
            title: S.of(context).login,
            icon: AppIcons.loginLine,
            description: S.of(context).message_to_login,
          ),
          const SizedBox(height: Dimens.dp32),
          _buildForm(),
          const SizedBox(height: Dimens.dp24),
          HorizontalLineSection(text: S.of(context).or),
          const SizedBox(height: Dimens.dp24),
          _buildAlternativeLogin(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneTextInput(
          hintText: S.of(context).hint_input_whatsapp_number,
        ),
        const SizedBox(height: Dimens.dp24),
        PrimaryButton(onPressed: () {}, child: Text(S.of(context).login)),
      ],
    );
  }

  Widget _buildAlternativeLogin() {
    return PrimaryButton(
      color: StaticColors.red,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(S.of(context).login_with('Email')),
    );
  }
}
