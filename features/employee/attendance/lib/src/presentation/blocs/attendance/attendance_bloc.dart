import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

import '../../../../attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceClockUseCase useCase;
  AttendanceBloc(this.useCase) : super(AttendanceInitial());

  @override
  Stream<AttendanceState> mapEventToState(
    AttendanceEvent event,
  ) async* {
    if (event is GetAttendanceEvent) {
      yield* _mapGetAttendanceToState(event);
    }
  }

  Stream<AttendanceState> _mapGetAttendanceToState(
      GetAttendanceEvent event) async* {
    try {
      yield AttendanceLoading();

      final result = await useCase(event.data);

      yield* result.fold((l) async* {
        yield AttendanceFailure(l);
      }, (r) async* {
        yield AttendanceSuccess(r);
      });
    } catch (e, stackTrace) {
      GetIt.I<RecordErrorUseCase>()(
        RecordErrorParams(
          exception: e,
          stackTrace: stackTrace,
        ),
      );
      yield AttendanceFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
