part of 'server_bloc.dart';

abstract class CheckServerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckServerInitial extends CheckServerState {
  @override
  List<Object> get props => [];
}

class CheckServerLoading extends CheckServerState {
  @override
  List<Object> get props => [];
}

class CheckServerSuccess extends CheckServerState {
  final ServerModel data;

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
