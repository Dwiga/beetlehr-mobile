import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'check_attendance_event.dart';
part 'check_attendance_state.dart';

class CheckAttendanceBloc
    extends Bloc<CheckAttendanceEvent, CheckAttendanceState> {
  final GetCheckActiveAttendanceUseCase useCase;
  CheckAttendanceBloc(this.useCase) : super(CheckAttendanceInitial());

  @override
  Stream<CheckAttendanceState> mapEventToState(
    CheckAttendanceEvent event,
  ) async* {
    if (event is FetchCheckAttendanceEvent) {
      yield* _mapFetchCheckAttendance(event);
    }
  }

  Stream<CheckAttendanceState> _mapFetchCheckAttendance(
      FetchCheckAttendanceEvent event) async* {
    try {
      yield CheckAttendanceLoading();
      final result = await useCase(CheckAcceptClockBodyModel(
        date: event.date,
        type: event.type,
        clock: DateFormat('HH:mm:ss').format(event.date),
      ));

      yield* result.fold((l) async* {
        yield CheckAttendanceFailure(l);
      }, (r) async* {
        yield CheckAttendanceSuccess(
          isAccept: r,
          type: event.type,
          workingFrom: event.workingFrom,
        );
      });
    } catch (e) {
      yield CheckAttendanceFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
