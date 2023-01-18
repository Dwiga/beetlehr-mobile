import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class AppMenuSection extends StatelessWidget {
  final bool isAvailableSettingStartup;

  const AppMenuSection({Key? key, required this.isAvailableSettingStartup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle1Text(S.of(context).app_setting),
          const SizedBox(height: Dimens.dp16),
          // ListMenuTile(
          //   leadingColor: StaticColors.orange,
          //   leadingIcon: AppIcons.notificationLine,
          //   title: S.of(context).notification,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),git bra
          // _buildDivider(),
          ListMenuTile(
            leadingColor: StaticColors.lightBlue,
            leadingIcon: AppIcons.languageLine,
            title: S.of(context).change_language,
            onTap: () {
              Navigator.of(context).pushNamed('/setting-language');
            },
            trailing: _buildTrailing(context),
          ),
          // _buildDivider(),
          // ListMenuTile(
          //   leadingColor: StaticColors.green,
          //   leadingIcon: AppIcons.filesGroupLine,
          //   title: S.of(context).term_of_use,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),
          if (isAvailableSettingStartup) ...[
            _buildDivider(),
            ListMenuTile(
              leadingColor: StaticColors.green,
              leadingIcon: AppIcons.lockLine,
              title: S.of(context).auto_start_permission,
              onTap: () => _confirmationChangeAutoStartPermission(context),
              trailing: _buildTrailing(context),
            )
          ],
          // _buildDivider(),
          // ListMenuTile(
          //   leadingColor: StaticColors.grey,
          //   leadingIcon: AppIcons.lockLine,
          //   title: S.of(context).privacy_policy,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),
          // _buildDivider(),
          // ListMenuTile(
          //   leadingColor: StaticColors.indigo,
          //   leadingIcon: AppIcons.infoCircleLine,
          //   title: S.of(context).about_us,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),
        ],
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color: Theme.of(context).disabledColor,
      size: Dimens.dp24,
    );
  }

  Widget _buildDivider() {
    return Row(
      children: const [
        SizedBox(width: 60),
        Expanded(child: Divider(height: 1, thickness: 1)),
      ],
    );
  }

  void _confirmationChangeAutoStartPermission(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AppAlertDialog(
            body: Text('Pastikan ketika menggunakan aplikasi'
                ' ${GetIt.I<GlobalConfiguration>().getValue('app_name')}'
                ' dalam posisi aktif'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).yes),
              ),
            ],
          );
        });
  }
}
