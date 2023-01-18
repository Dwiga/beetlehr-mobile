import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:auth/auth.dart';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:home_customer/home.dart';
import 'package:home_employee/home.dart';
import 'package:l10n/l10n.dart';
import 'package:settings/settings.dart';

import '../config/config.dart';
import '../di/injection.dart';
import '../routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _setTransparentStatusBar();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => getIt<ThemeBloc>()),
        BlocProvider<LanguageBloc>(
          create: (context) =>
              getIt<LanguageBloc>()..add(InitializeLanguageEvent()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthInitializeEvent()),
        ),
        BlocProvider<AccessBloc>(
          create: (context) =>
              getIt<AccessBloc>()..add(StartCheckAccessEvent()),
        ),
        BlocProvider(create: (_) => GetIt.I<ClockButtonTypeBloc>()),
        BlocProvider(create: (_) => GetIt.I<ConnectionModeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, langState) {
            return MaterialApp(
              title: getIt<GlobalConfiguration>().getValue('app_name') ?? '',
              scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
              navigatorObservers: [
                SnackbarNavigatorObserver(),
                SentryNavigatorObserver(),
              ],
              theme: state.theme,
              navigatorKey: getIt<GlobalKey<NavigatorState>>(),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: langState.country != null
                  ? Locale(
                      langState.country!.code,
                      langState.country!.code,
                    )
                  : null,
              onGenerateRoute: AppRoutes.routes,
              debugShowCheckedModeBanner: false,
              home: BlocListener<AccessBloc, AccessState>(
                listener: (context, state) {
                  if (kReleaseMode) {
                    if (state is AccessUseRoot) {
                      _showDialogCannotAccessApp(
                          context, S.of(context).message_app_use_root);
                    } else if (state is AccessUseMockLocation) {
                      _showDialogCannotAccessApp(
                          context, S.of(context).message_app_use_mock_location);
                    }
                  }
                },
                child: VersionAppPage(child: MainEmployeePage()),
              ),
            );
          });
        },
      ),
    );
  }

  void _setTransparentStatusBar() {
    if (BaseConfig.transparentStatusBar) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      );
    }
  }

  void _showDialogCannotAccessApp(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppAlertDialog(
        body: Text(message),
        actions: [
          TextButton(
            child: Text(S.of(context).exit),
            onPressed: () {
              if (Platform.isIOS) {
                exit(0);
              } else {
                SystemNavigator.pop();
              }
            },
          ),
        ],
      ),
    ).whenComplete(() {
      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
    });
  }
}
