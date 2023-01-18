import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'break_time_event.dart';
part 'break_time_state.dart';

class BreakTimeBloc extends Bloc<BreakTimeEvent, BreakTimeState> {
  final BreakTimeUseCase useCase;
  BreakTimeBloc(this.useCase) : super(BreakTimeInitial());

  @override
  Stream<BreakTimeState> mapEventToState(
    BreakTimeEvent event,
  ) async* {
    if (event is FetchBreakTimeEvent) {
      yield* _mapFetchBreakTime(event);
    }
  }

  Stream<BreakTimeState> _mapFetchBreakTime(FetchBreakTimeEvent event) async* {
    try {
      yield BreakTimeLoading();
      final result = await useCase(BreakTimeBodyModel(
        date: DateFormat('y-MM-dd').format(event.date),
        type: event.type,
        clock: DateFormat('HH:mm:ss').format(event.date),
        notes: null,
        latitude: null,
        longitude: null,
        imageId: null,
        address: null,
        files: const <String>[],
      ));

      yield* result.fold((l) async* {
        yield BreakTimeFailure(l);
      }, (r) async* {
        yield BreakTimeSuccess(r);
      });
    } catch (e) {
      yield BreakTimeFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
