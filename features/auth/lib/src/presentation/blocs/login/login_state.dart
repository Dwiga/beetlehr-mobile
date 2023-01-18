part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const EmailFormZ.pure(),
    this.password = const PasswordFormZ.pure(),
    this.user,
    this.failure,
  });

  final FormzStatus status;
  final EmailFormZ email;
  final PasswordFormZ password;
  final UserEntity? user;
  final Failure? failure;

  LoginState copyWith({
    FormzStatus? status,
    EmailFormZ? email,
    PasswordFormZ? password,
    UserEntity? user,
    Failure? failure,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, email, password, user, failure];

  @override
  bool get stringify => true;
}
