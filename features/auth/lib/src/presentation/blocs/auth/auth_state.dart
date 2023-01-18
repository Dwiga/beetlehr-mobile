part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthState.unKnow() : this._();
  const AuthState.authenticated(UserEntity user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );
  const AuthState.unAuthenticated()
      : this._(
          status: AuthenticationStatus.unAuthenticated,
          user: null,
        );

  final UserEntity? user;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => [user, status];

  @override
  bool get stringify => true;
}
