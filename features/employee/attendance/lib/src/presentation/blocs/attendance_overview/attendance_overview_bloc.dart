import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'attendance_overview_event.dart';
part 'attendance_overview_state.dart';

class AttendanceOverviewBloc
    extends Bloc<AttendanceOverviewEvent, AttendanceOverviewState> {
  final GetAttendanceOverviewUseCase getAttendanceOverviewUseCase;
  AttendanceOverviewBloc(this.getAttendanceOverviewUseCase)
      : super(AttendanceOverviewLoading());

  @override
  Stream<AttendanceOverviewState> mapEventToState(
    AttendanceOverviewEvent event,
  ) async* {
    if (event is FetchAttendanceOverviewEvent) {
      yield* _mapFetchAttendanceOverviewToState(event, state);
    }
  }

  Stream<AttendanceOverviewState> _mapFetchAttendanceOverviewToState(
      FetchAttendanceOverviewEvent event,
      AttendanceOverviewState state) async* {
    try {
      final _currentState = state;
      if (_currentState is AttendanceOverviewSuccess && event.refresh != true) {
        return;
      } else {
        yield AttendanceOverviewLoading();
      }
      final result = await getAttendanceOverviewUseCase(
          AttendanceOverviewParams(date: event.date));
      yield* result.fold(
        (l) async* {
          if (_currentState is! AttendanceOverviewSuccess) {
            yield AttendanceOverviewFailure(l);
          } else {
            yield _currentState;
          }
        },
        (r) async* {
          yield AttendanceOverviewSuccess(data: r);
        },
      );
    } catch (e) {
      yield AttendanceOverviewFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
