part of 'check_placement_bloc.dart';

abstract class CheckPlacementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCheckPlacementEvent extends CheckPlacementEvent {
  final double latitude;
  final double longitude;
  final WorkingFromType workingFrom;

  FetchCheckPlacementEvent({
    required this.latitude,
    required this.longitude,
    required this.workingFrom,
  });

  @override
  List<Object> get props => [latitude, longitude, workingFrom];
}
