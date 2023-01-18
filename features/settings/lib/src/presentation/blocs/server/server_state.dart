part of 'server_bloc.dart';

abstract class CheckServerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckServerInitial extends CheckServerState {}

class CheckServerLoading extends CheckServerState {}

class CheckServerSuccess extends CheckServerState {
  final CheckServerModel? data;

  CheckServerSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class CheckServerFailure extends CheckServerState {
  final Failure failure;

  CheckServerFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
