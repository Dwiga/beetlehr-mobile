import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';

import '../../../settings.dart';

class UpdateAppPage extends StatelessWidget {
  final bool mustUpgrade;
  final VoidCallback? onSkip;

  const UpdateAppPage({
    Key? key,
    required this.mustUpgrade,
    this.onSkip,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: _buildBody(context),
        bottomNavigationBar: SafeArea(child: _buildBottomNav(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.width(context) * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          TitleText(
            'Aplikasi terbaru sudah tersedia',
            align: TextAlign.center,
          ),
          SizedBox(height: Dimens.dp16),
          RegularText(
            'Yuk Segera perbarui ke aplikasi terbaru, '
            'untuk meningkatkan fitur dan kenyamanan Anda.',
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    if (mustUpgrade) {
      return Container(
        height: 64,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp8, horizontal: Dimens.dp16),
        child: PrimaryButton(
          child: const Text('Update Sekarang'),
          onPressed: _navigateToStore,
        ),
      );
    } else {
      return Container(
        height: 64,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.dp8, horizontal: Dimens.dp16),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                child: const Text('Lain Kali'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onSkip?.call();
                },
              ),
            ),
            const SizedBox(width: Dimens.dp16),
            Expanded(
              child: PrimaryButton(
                onPressed: _navigateToStore,
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToStore() async {
    GetIt.I<GetAppUrlUseCase>().call(NoParams()).then((value) {
      value.fold((l) {}, (url) async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      });
    });
  }

  Future<bool> _onBack() async {
    if (mustUpgrade) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else {
        exit(0);
      }
    }
    return true;
  }
}
