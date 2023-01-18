import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'check_placement_event.dart';
part 'check_placement_state.dart';

class CheckPlacementBloc
    extends Bloc<CheckPlacementEvent, CheckPlacementState> {
  final GetCheckPlacementOfficeUseCase useCase;
  CheckPlacementBloc(this.useCase) : super(CheckPlacementLoading());

  @override
  Stream<CheckPlacementState> mapEventToState(
    CheckPlacementEvent event,
  ) async* {
    if (event is FetchCheckPlacementEvent) {
      yield* _mapFetchPlacementToState(event);
    }
  }

  Stream<CheckPlacementState> _mapFetchPlacementToState(
      FetchCheckPlacementEvent event) async* {
    try {
      yield CheckPlacementLoading();
      final result = await useCase(CheckPlacementBodyModel(
        latitude: event.latitude,
        longitude: event.longitude,
        workingFrom: event.workingFrom,
      ));

      yield* result.fold((l) async* {
        yield CheckPlacementFailure(failure: l);
      }, (r) async* {
        yield CheckPlacementSuccess(
          data: r,
          currentLatLng: LatLng(event.latitude, event.longitude),
        );
      });
    } catch (e) {
      yield CheckPlacementFailure(
          failure: DefaultServerFailure(message: e.toString()));
    }
  }
}
