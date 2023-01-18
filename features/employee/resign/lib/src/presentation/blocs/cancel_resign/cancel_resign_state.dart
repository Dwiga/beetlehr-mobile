part of 'cancel_resign_bloc.dart';

abstract class CancelResignState extends Equatable {}

class CancelResignInitial extends CancelResignState {
  @override
  List<Object> get props => [];
}

class CancelResignLoading extends CancelResignState {
  @override
  List<Object> get props => [];
}

class CancelResignSuccess extends CancelResignState {
  @override
  List<Object> get props => [];
}

class CancelResignFailure extends CancelResignState {
  final Failure failure;

  CancelResignFailure(this.failure);
  @override
  List<Object> get props => [];
}
