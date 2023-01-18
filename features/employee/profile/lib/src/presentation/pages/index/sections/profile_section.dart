import 'package:auth/auth.dart';
import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../profile.dart';
import '../../../component/component.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          if (authBloc.state.status == AuthenticationStatus.authenticated) {
            authBloc.add(
              AuthLoginEvent(
                state.data.toUser(authBloc.state.user?.id ?? 0),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return AboutProfileCard(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/profile/view',
                  arguments: {
                    'profile': state.data,
                  });

              if (result == true) {
                BlocProvider.of<ProfileBloc>(context).add(
                  FetchProfileEvent(refresh: true),
                );
              }
            },
            user: state.data,
          );
        } else if (state is ProfileFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: () {
              BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent());
            },
          );
        }
        return _LoadingContent();
      },
    );
  }
}

class _LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Row(
        children: [
          const Skeleton(
            height: 80,
            width: 80,
            radius: 40,
          ),
          const SizedBox(width: Dimens.dp16),
          Expanded(
            child: Column(
              children: const [
                Skeleton(height: Dimens.dp16),
                SizedBox(height: Dimens.dp8),
                Skeleton(height: Dimens.dp16),
                SizedBox(height: Dimens.dp8),
              ],
            ),
          ),
          const SizedBox(width: Dimens.dp32),
        ],
      ),
    );
  }
}

class _FailureContent extends StatelessWidget {
  final String? message;
  final VoidCallback? onRefresh;

  const _FailureContent({Key? key, this.message, this.onRefresh})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.dp16),
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message ?? 'Sepertinya ada yang salah silahkan coba lagi',
            ),
          ),
          const SizedBox(width: Dimens.dp16),
          PrimaryButton(
            child: Text(S.of(context).reload),
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}
