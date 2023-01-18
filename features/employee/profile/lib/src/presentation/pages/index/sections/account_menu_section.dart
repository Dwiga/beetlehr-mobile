import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class AccountMenuSection extends StatelessWidget {
  const AccountMenuSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle1Text(S.of(context).account_setting),
          const SizedBox(height: Dimens.dp16),
          // ListMenuTile(
          //   leadingColor: Theme.of(context).primaryColor,
          //   leadingIcon: AppIcons.filesGroupLine,
          //   title: S.of(context).my_files,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),
          // _buildDivider(),
          // ListMenuTile(
          //   leadingColor: StaticColors.red,
          //   leadingIcon: AppIcons.phoneHandsetLine,
          //   title: S.of(context).emergency_contact,
          //   onTap: () {},
          //   trailing: _buildTrailing(context),
          // ),
          // _buildDivider(),
          ListMenuTile(
            leadingColor: StaticColors.green,
            leadingIcon: AppIcons.walletLine,
            title: S.of(context).payroll,
            onTap: () {
              Navigator.pushNamed(context, '/payroll');
            },
            trailing: _buildTrailing(context),
          ),
          _buildDivider(),
          ListMenuTile(
            leadingColor: Theme.of(context).primaryColorLight,
            leadingIcon: AppIcons.loginLine,
            title: S.of(context).leave_application,
            onTap: () {
              Navigator.pushNamed(context, '/leave-application');
            },
            trailing: _buildTrailing(context),
          ),
          _buildDivider(),
          ListMenuTile(
            leadingColor: StaticColors.indigo,
            leadingIcon: AppIcons.employeeLine,
            title: S.of(context).resign_application,
            onTap: () {
              Navigator.pushNamed(context, '/resign-application');
            },
            trailing: _buildTrailing(context),
          ),
          // _buildDivider(),
          // ListMenuTile(
          //   leadingColor: StaticColors.sunriseYellow,
          //   leadingIcon: Icons.star_border_rounded,
          //   title: "My Performance",
          //   onTap: () {
          //     Navigator.pushNamed(context, '/profile/performance');
          //   },
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
}
