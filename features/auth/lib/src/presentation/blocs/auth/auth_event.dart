part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AuthInitializeEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final UserEntity user;

  const AuthLoginEvent(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLogoutEvent extends AuthEvent {}
