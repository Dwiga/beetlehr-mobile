part of 'reset_pass_bloc.dart';

abstract class ResetPassEvent extends Equatable {}

class ResetPassEmailChanged extends ResetPassEvent {
  final String email;
  ResetPassEmailChanged({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class ResetPassSubmitted extends ResetPassEvent {
  @override
  List<Object> get props => [];
}
