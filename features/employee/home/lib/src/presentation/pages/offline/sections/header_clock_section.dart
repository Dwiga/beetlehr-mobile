import 'package:attendance/attendance.dart';
import 'package:auth/auth.dart';
import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home_employee/home.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class HeaderClockSection extends StatefulWidget {
  final VoidCallback? onTapClockIn;
  final VoidCallback? onTapClockOut;

  final ClockOfflineButtonTypeState state;

  const HeaderClockSection({
    Key? key,
    this.onTapClockIn,
    this.onTapClockOut,
    required this.state,
  }) : super(key: key);

  @override
  _HeaderClockSectionState createState() => _HeaderClockSectionState();
}

class _HeaderClockSectionState extends State<HeaderClockSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SubTitle1Text(
          DateFormat('EEE, d MMM y').format(DateTime.now()).toString(),
          style: TextStyle(color: Theme.of(context).primaryColor),
          maxLine: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimens.dp8),
        _buildProfileCard(),
        const SizedBox(height: Dimens.dp12),
        _buildBtnClockIn(),
      ],
    );
  }

  Widget _buildProfileCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return UserProfileCard(
            email: state.user?.email ?? '',
            imageUrl: state.user?.image ??
                'https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png',
            name: state.user?.name ?? '',
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildBtnClockIn() {
    if (widget.state.type == ClockButtonType.clockIn) {
      return PrimaryButton(
        onPressed: widget.onTapClockIn,
        color: Theme.of(context).primaryColor,
        child: Text(S.of(context).clock_in + " " + S.of(context).offline),
      );
    } else if (widget.state.type == ClockButtonType.clockOut) {
      return PrimaryButton(
        onPressed: widget.onTapClockOut,
        color: StaticColors.red,
        child: Text(S.of(context).clock_out + " " + S.of(context).offline),
      );
    }

    return PrimaryButton(
      onPressed: () {},
      color: StaticColors.green,
      child: Text(S.current.resolved_attendance),
    );
  }
}
