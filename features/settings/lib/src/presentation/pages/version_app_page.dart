import 'dart:async';
import 'dart:developer';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../settings.dart';

class VersionAppPage extends StatefulWidget {
  final Widget child;
  const VersionAppPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _VersionAppPageState createState() => _VersionAppPageState();
}

class _VersionAppPageState extends State<VersionAppPage> {
  bool afterSkipUpdate = false;
  Timer? _timer;

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  void _initTimer() {
    _timer?.cancel();
    _refreshConfig();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _refreshConfig();
    });
  }

  void _refreshConfig() async {
    try {
      FirebaseRemoteConfig.instance.fetchAndActivate();
      // final url = await GetIt.I<RemoteConfigService>().getValue('base_url_api');

      // GetIt.I<Dio>().options.baseUrl = url.asString();
      // RemoteConfigService().saveBaseURL(url.asString());
    } catch (e, stackTrace) {
      log('ERROR REMOTE CONFIG: $e', error: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseRemoteConfig>(
      future: GetIt.I<RemoteConfigService>().initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (kReleaseMode) {
            _checkAppVersion();
          }
        }
        return widget.child;
      },
    );
  }

  void _checkAppVersion() async {
    final result = await GetIt.I<RemoteConfigService>().checkAppVersion();
    if (result == AppVersionType.expired) {
      Future.microtask(
        () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const UpdateAppPage(
              mustUpgrade: true,
            ),
          ),
        ),
      );
    } else if (result == AppVersionType.haveUpdate && !afterSkipUpdate) {
      Future.microtask(
        () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => UpdateAppPage(
              mustUpgrade: false,
              onSkip: () {
                setState(() {
                  afterSkipUpdate = true;
                });
              },
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
