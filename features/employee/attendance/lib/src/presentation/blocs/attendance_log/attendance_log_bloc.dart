import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'attendance_log_event.dart';
part 'attendance_log_state.dart';

class AttendanceLogBloc extends Bloc<AttendanceLogEvent, AttendanceLogState> {
  final GetAttendanceLogUseCase getAttendanceLogUseCase;
  AttendanceLogBloc(
    this.getAttendanceLogUseCase,
  ) : super(AttendanceLogLoading());

  @override
  Stream<AttendanceLogState> mapEventToState(
    AttendanceLogEvent event,
  ) async* {
    if (event is FetchAttendanceLogEvent) {
      yield* _mapFetchAttendanceLogToState(event);
    }
  }

  Stream<AttendanceLogState> _mapFetchAttendanceLogToState(
    FetchAttendanceLogEvent event,
  ) async* {
    try {
      yield AttendanceLogLoading();
      final result = await getAttendanceLogUseCase(
        AttendanceLogParams(
          month: event.period.month,
          year: event.period.year,
          status: event.status,
        ),
      );

      yield* result.fold((l) async* {
        yield AttendanceLogFailure(
          failure: l,
        );
      }, (r) async* {
        yield AttendanceLogSuccess(
          period: event.period,
          data: r,
        );
      });
    } catch (e) {
      yield AttendanceLogFailure(
          failure: DefaultServerFailure(message: e.toString()));
    }
  }
}
