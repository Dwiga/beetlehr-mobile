part of 'access_bloc.dart';

abstract class AccessEvent extends Equatable {}

class StartCheckAccessEvent extends AccessEvent {
  @override
  List<Object> get props => [];
}

class ChangeMockLocationAccessEvent extends AccessEvent {
  final bool isMockLocation;

  ChangeMockLocationAccessEvent({required this.isMockLocation});
  @override
  List<Object> get props => [isMockLocation];
}
