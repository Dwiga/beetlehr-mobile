part of 'resign_bloc.dart';

abstract class ResignState extends Equatable {}

class ResignLoading extends ResignState {
  @override
  List<Object> get props => [];
}

class ResignSuccess extends ResignState {
  final ResignEntity? data;

  ResignSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ResignFailure extends ResignState {
  final Failure failure;

  ResignFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
