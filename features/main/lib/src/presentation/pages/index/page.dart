import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home_employee/home.dart';
import 'package:settings/settings.dart';
import '../pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, Uri?>>(
      future: GetIt.I<GetBaseUrlUseCase>().call(NoParams()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _setBaseUrl(snapshot.data);

          if (snapshot.data
                  ?.getOrElse(() => Uri.parse(''))
                  .toString()
                  .isEmpty ??
              false) {
            return SettingUrlPage(
              onTap: (newUrl) {
                setState(() {
                  // GetIt.I<SetBaseUrlUseCase>().call(newUrl);
                });
              },
            );
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
              // todo: check user is customer or employee

              // When User is Customer
              return const MainEmployeePage();

              // When User is Employee
              // return MainEmployeePage();
            } else if (state.status == AuthenticationStatus.unAuthenticated) {
              return const LoginWithEmailPage();
            } else {
              return const SplashPage();
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

  @override
  void dispose() {
    super.dispose();
  }
}
