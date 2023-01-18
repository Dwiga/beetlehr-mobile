part of 'leave_cancel_bloc.dart';

abstract class LeaveCancelState extends Equatable {}

class LeaveCancelLoading extends LeaveCancelState {
  @override
  List<Object> get props => [];
}

class LeaveCancelSuccess extends LeaveCancelState {
  @override
  List<Object> get props => [];
}

class LeaveCancelFailure extends LeaveCancelState {
  final Failure failure;

  LeaveCancelFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
