import 'dart:async';

import 'package:attendance/attendance.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/notice.dart';
import 'package:preferences/preferences.dart';
import 'package:profile/profile.dart';
import 'package:settings/settings.dart';

import '../../../home.dart';
import '../presentation.dart';

class MainEmployeePage extends StatefulWidget {
  const MainEmployeePage({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainEmployeePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, Uri?>>(
      future: GetIt.I<GetBaseUrlUseCase>().call(NoParams()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _setBaseUrl(snapshot.data);
          final bool urlEditable =
              GetIt.I<GlobalConfiguration>().getValue('url_editable');

          if (snapshot.data
                  ?.getOrElse(() => Uri.parse(''))
                  .toString()
                  .isEmpty ??
              false) {
            if (urlEditable) {
              return SettingUrlPage(
                onTap: (newUrl) {
                  setState(() {});
                },
              );
            }
          }
        }

        return BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            if (previous.status != current.status || previous != current) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return const _InternetChecker();
            } else if (state.status == AuthenticationStatus.unAuthenticated) {
              return const LoginWithEmailPage();
            } else {
              return const _SplashPage();
            }
          },
        );
      },
    );
  }

  void _setBaseUrl(Either<Failure, Uri?>? data) {
    final url = data?.foldRight(null, (r, previous) => r);
    final defaultUrl = GetIt.I<GlobalConfiguration>().getValue('base_url');

    if (url == null) {
      GetIt.I<Dio>().options.baseUrl = defaultUrl;
    } else {
      GetIt.I<Dio>().options.baseUrl = url.toString();
    }
  }
}

class _InternetChecker extends StatefulWidget {
  const _InternetChecker({Key? key}) : super(key: key);

  @override
  State<_InternetChecker> createState() => _InternetCheckerState();
}

class _InternetCheckerState extends State<_InternetChecker> {
  bool _isAfterInitialized = false;

  Future _initInternetConnectionState() async {
    try {
      final hasConnection =
          await GetIt.I<InternetConnectionChecker>().hasConnection;

      if (hasConnection) {
        _syncSavedAttendance();
      } else {
        if (mounted) {
          setState(() {
            _isAfterInitialized = true;
          });
        }
      }

      BlocProvider.of<ConnectionModeBloc>(context).add(
        ConnectionModeChanged(
            hasConnection ? ConnectionMode.online : ConnectionMode.offline),
      );
    } catch (_) {}
  }

  Future _syncSavedAttendance() async {
    try {
      if (mounted) {
        setState(() {
          _isAfterInitialized = false;
        });
      }
      await GetIt.I<SyncAttendancesUseCase>().call(NoParams()).then((value) {
        value.fold((failure) {
          if (failure.code != null && failure.code! >= 400) {
            BlocProvider.of<ConnectionModeBloc>(context)
                .add(const ConnectionModeChanged(ConnectionMode.offline));
          } else {
            BlocProvider.of<ConnectionModeBloc>(context)
                .add(const ConnectionModeChanged(ConnectionMode.online));
          }

          GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
            exception: DefaultApiException(
                message: failure.message, code: failure.code),
            stackTrace: StackTrace.current,
            errorMessage: 'Failed to sync saved attendance',
            level: SentryLevel.fatal,
            tags: const ['sync_saved_attendance'],
          ));
        }, (success) {
          GetIt.I<ClearSavedAttendancesUseCase>().call(false);
        });
      });
    } catch (exception, stackTrace) {
      GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
        exception: exception,
        stackTrace: stackTrace,
        errorMessage: 'Failed to sync saved attendance',
        level: SentryLevel.fatal,
        tags: const ['sync_saved_attendance'],
      ));
    } finally {
      if (mounted) {
        setState(() {
          _isAfterInitialized = true;
        });
      }
    }
  }

  @override
  void initState() {
    _initInternetConnectionState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAfterInitialized) {
      return BlocConsumer<ConnectionModeBloc, ConnectionMode>(
        listener: (context, state) {
          if (state == ConnectionMode.online) {
            if (mounted) {
              setState(() {
                _isAfterInitialized = false;
              });
            }
            _syncSavedAttendance();
          }
        },
        builder: (context, state) {
          if (state == ConnectionMode.offline) {
            return const HomeOfflinePage();
          } else if (state == ConnectionMode.online) {
            return const _MainNavigation();
          }

          return const _SplashPage();
        },
      );
    }

    return const _SplashPage();
  }
}

class _MainNavigation extends StatefulWidget {
  const _MainNavigation({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<_MainNavigation> {
  final _bloc = GetIt.I<BottomNavBloc>();

  final List<Widget> _pages = const [
    HomeOnlinePage(),
    NoticePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<CheckAttendanceBloc>()),
        BlocProvider(create: (context) => GetIt.I<AttendanceOverviewBloc>()),
        BlocProvider(create: (_) => GetIt.I<NoticeBoardBloc>()),
        BlocProvider(create: (_) => GetIt.I<ScheduleBloc>()),
        BlocProvider(create: (_) => GetIt.I<ProfileBloc>()),
        BlocProvider(create: (context) => _bloc),
      ],
      child: BlocBuilder<BottomNavBloc, int>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state),
            bottomNavigationBar: _buildBottomNav(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    return BlocBuilder<BottomNavBloc, int>(
      builder: (context, state) {
        return _pages[state];
      },
    );
  }

  Widget _buildBottomNav(int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (v) async {
        _bloc.add(ChangeBottomNavEvent(index: v));
      },
      iconSize: Dimens.dp20,
      selectedFontSize: Dimens.dp10,
      unselectedFontSize: Dimens.dp10,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(AppIcons2.homeLine),
            activeIcon: Icon(AppIcons2.homeSolid),
            label: 'Home'),
        const BottomNavigationBarItem(
            icon: Icon(AppIcons2.messageLine),
            activeIcon: Icon(AppIcons2.messageSolid),
            label: "Inbox"),
        BottomNavigationBarItem(
            icon: const Icon(AppIcons2.userLine),
            activeIcon: const Icon(AppIcons2.userSolid),
            label: S.of(context).profile),
      ],
    );
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage({Key? key}) : super(key: key);

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
