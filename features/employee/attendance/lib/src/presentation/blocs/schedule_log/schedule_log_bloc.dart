import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'schedule_log_event.dart';
part 'schedule_log_state.dart';

class ScheduleLogBloc extends Bloc<ScheduleLogEvent, ScheduleLogState> {
  ScheduleLogBloc(this.getScheduleLog) : super(ScheduleLogLoading());

  final GetScheduleLogUseCase getScheduleLog;

  @override
  Stream<ScheduleLogState> mapEventToState(
    ScheduleLogEvent event,
  ) async* {
    if (event is FetchScheduleLogEvent) {
      yield* _mapFetchScheduleLogToState(event);
    }
  }

  Stream<ScheduleLogState> _mapFetchScheduleLogToState(
    FetchScheduleLogEvent event,
  ) async* {
    try {
      yield ScheduleLogLoading();
      final result = await getScheduleLog(
        ScheduleLogParams(
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      );

      yield* result.fold((l) async* {
        yield ScheduleLogFailure(
          failure: l,
        );
      }, (r) async* {
        yield ScheduleLogSuccess(
          data: r,
          period: DateTime(event.startDate.year, event.startDate.month),
        );
      });
    } catch (e) {
      yield ScheduleLogFailure(
          failure: DefaultServerFailure(message: e.toString()));
    }
  }
}
