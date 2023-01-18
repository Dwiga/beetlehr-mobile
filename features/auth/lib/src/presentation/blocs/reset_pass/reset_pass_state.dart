part of 'reset_pass_bloc.dart';

class ResetPassState extends Equatable {
  final FormzStatus status;
  final EmailFormZ email;
  final Failure? failure;

  const ResetPassState({
    this.status = FormzStatus.pure,
    this.email = const EmailFormZ.pure(),
    this.failure,
  });

  ResetPassState copyWith({
    FormzStatus? status,
    EmailFormZ? email,
    Failure? failure,
  }) {
    return ResetPassState(
      status: status ?? this.status,
      email: email ?? this.email,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, email, failure];
}
