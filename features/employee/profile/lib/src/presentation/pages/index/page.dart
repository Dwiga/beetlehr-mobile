import 'package:auth/auth.dart';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../profile.dart';
import 'sections/sections.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  String _getVersionApp() {
    var appName = GetIt.I<GlobalConfiguration>().getValue('app_name') ?? '';
    var appVersion =
        GetIt.I<GlobalConfiguration>().getValue('version_name') ?? '';
    return '$appName v$appVersion';
  }

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).profile),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: [
        const ProfileSection(),
        _buildEmptySpace(),
        const AccountMenuSection(),
        _buildEmptySpace(),
        const AppMenuSection(isAvailableSettingStartup: false),
        _buildLogOut(),
      ],
    );
  }

  Widget _buildEmptySpace() {
    return Divider(
      thickness: Dimens.dp24,
      color: Theme.of(context).disabledColor.withOpacity(0.1),
    );
  }

  Widget _buildLogOut() {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: _onTapLogOut,
            child: SubTitle2Text(
              S.of(context).log_out,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
          RegularText(
            _getVersionApp(),
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
        ],
      ),
    );
  }

  void _onTapLogOut() async {
    // final isRunning = await BackgroundLocator.isServiceRunning();
    // if (isRunning) {
    //   _showDialogActiveTracking();
    // } else {
    _showDialogLogOut();
    // }
  }

  void _showDialogLogOut() {
    showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        body: Text(S.of(context).message_confirm_logout),
        actions: [
          TextButton(
            child: Text(S.of(context).no),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(S.of(context).yes),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // void _showDialogActiveTracking() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AppAlertDialog(
  //       body: Text(S.of(context).cannot_logout_intrack_message),
  //       actions: [
  //         TextButton(
  //           child: Text(S.of(context).yes),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
