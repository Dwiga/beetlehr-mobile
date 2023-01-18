part of 'connection_mode_bloc.dart';

abstract class ConnectionModeEvent extends Equatable {
  const ConnectionModeEvent();
}

class ConnectionModeChanged extends ConnectionModeEvent {
  final ConnectionMode connectionMode;
  final bool refresh;

  const ConnectionModeChanged(this.connectionMode, {this.refresh = false});

  @override
  List<Object?> get props => [connectionMode, refresh];
}

class ConnectionModeRefreshed extends ConnectionModeEvent {
  const ConnectionModeRefreshed();

  @override
  List<Object?> get props => [];
}
