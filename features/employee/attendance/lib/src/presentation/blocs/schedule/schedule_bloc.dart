import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetScheduleUseCase useCase;
  ScheduleBloc(this.useCase) : super(ScheduleLoading());

  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    if (event is FetchScheduleEvent) {
      yield* _mapFetchScheduleToState(event, state);
    }
  }

  Stream<ScheduleState> _mapFetchScheduleToState(
      FetchScheduleEvent event, ScheduleState state) async* {
    try {
      final _currentState = state;
      if (_currentState is ScheduleSuccess && event.refresh != true) {
        return;
      } else {
        yield ScheduleLoading();
      }

      final result = await useCase(ScheduleParams(event.date));

      yield* result.fold((l) async* {
        if (_currentState is! ScheduleSuccess) {
          yield ScheduleFailure(l);
        } else {
          yield _currentState;
        }
      }, (r) async* {
        yield ScheduleSuccess(_filterActiveSchedules(r));
      });
    } catch (e) {
      yield ScheduleFailure(DefaultServerFailure(message: e.toString()));
    }
  }

  List<ScheduleEntity> _filterActiveSchedules(List<ScheduleEntity> data) {
    var _result = <ScheduleEntity>[];

    for (var item in data) {
      if (item.isLeave == 0 && item.timeStart != null && item.timeEnd != null) {
        _result.add(item);
      }
    }

    return _result;
  }
}
