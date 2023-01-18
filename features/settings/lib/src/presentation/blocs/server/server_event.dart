part of 'server_bloc.dart';

abstract class CheckServerEvent extends Equatable {}

class FetchCheckServerEvent extends CheckServerEvent {
  final String endpoint;
  final BaseUrlSchema schema;
  FetchCheckServerEvent({required this.endpoint, required this.schema});

  @override
  List<Object?> get props => [endpoint, schema];
}
