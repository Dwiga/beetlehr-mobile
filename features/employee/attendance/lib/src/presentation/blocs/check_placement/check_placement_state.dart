part of 'check_placement_bloc.dart';

abstract class CheckPlacementState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckPlacementLoading extends CheckPlacementState {}

class CheckPlacementFailure extends CheckPlacementState {
  final Failure failure;
  CheckPlacementFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

class CheckPlacementSuccess extends CheckPlacementState {
  final OfficePlacementEntity data;
  final LatLng currentLatLng;

  CheckPlacementSuccess({
    required this.data,
    required this.currentLatLng,
  });

  @override
  List<Object> get props => [data];
}
