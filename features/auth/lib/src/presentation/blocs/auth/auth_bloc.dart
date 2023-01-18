// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

import '../../../../auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final LogOutUseCase logOutUseCase;
  final SaveTokenUseCase savePushNotificationUseCase;
  AuthBloc({
    required this.repository,
    required this.logOutUseCase,
    required this.savePushNotificationUseCase,
  }) : super(const AuthState.unKnow());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthLoginEvent) {
      yield* _mapLoginToState(event);
    } else if (event is AuthInitializeEvent) {
      yield* _mapInitializeToState();
    } else if (event is AuthLogoutEvent) {
      FirebaseMessaging.instance.deleteToken();
      yield* _mapLogOutToState();
    }
  }

  Stream<AuthState> _mapLoginToState(AuthLoginEvent event) async* {
    try {
      await repository.setSavedUser(UserModel.fromEntity(event.user));
      yield AuthState.authenticated(event.user);
      Sentry.configureScope(
        (scope) => scope.user = SentryUser(
          id: event.user.id.toString(),
          email: event.user.email,
          username: event.user.name.replaceAll(' ', '_'),
        ),
      );
      FirebaseMessaging.instance.deleteToken();
      final token = await FirebaseMessaging.instance.getToken();
      await savePushNotificationUseCase(token ?? '');
    } catch (_) {}
  }

  Stream<AuthState> _mapInitializeToState() async* {
    String? token;
    UserEntity? user;

    final tokenResult = await repository.getSavedToken();
    tokenResult.fold((l) => null, (r) {
      token = r.toString();
    });

    final userResult = await repository.getSavedUser();
    userResult.fold((l) => null, (r) {
      user = r;
    });

    if (token != null && user != null) {
      yield AuthState.authenticated(user!);
    } else {
      yield const AuthState.unAuthenticated();
      Sentry.configureScope((scope) => scope.user = null);
    }
  }

  Stream<AuthState> _mapLogOutToState() async* {
    yield* (await logOutUseCase(NoParams())).fold((l) async* {}, (r) async* {
      yield const AuthState.unAuthenticated();
      Sentry.configureScope((scope) => scope.user = null);
    });
  }
}
