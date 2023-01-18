part of 'server_bloc.dart';

abstract class CheckServerEvent extends Equatable {}

class FetchCheckServerEvent extends CheckServerEvent {
  final String endpoint;
  final String protocol;
  FetchCheckServerEvent({required this.endpoint, required this.protocol});

  @override
  List<Object?> get props => [endpoint, protocol];
}
