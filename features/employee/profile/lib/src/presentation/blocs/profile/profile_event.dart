part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class FetchProfileEvent extends ProfileEvent {
  final bool refresh;

  FetchProfileEvent({this.refresh = false});

  @override
  List<Object> get props => [refresh];
}
