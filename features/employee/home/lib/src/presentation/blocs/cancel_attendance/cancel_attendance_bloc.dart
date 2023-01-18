import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

part 'cancel_attendance_event.dart';
part 'cancel_attendance_state.dart';

class CancelAttendanceBloc
    extends Bloc<CancelAttendanceEvent, CancelAttendanceState> {
  CancelAttendanceBloc(this.useCase) : super(const CancelAttendanceInitial()) {
    on<CancelAttendanceSubmitted>(_onSubmit);
  }

  final CancelAttendanceUseCase useCase;

  Future _onSubmit(CancelAttendanceSubmitted event,
      Emitter<CancelAttendanceState> emit) async {
    try {
      emit(const CancelAttendanceInitial());
      emit(const CancelAttendanceLoading());

      final result = await useCase(NoParams());

      emit(
        result.fold(
          (failure) => CancelAttendanceFailure(failure),
          (success) => const CancelAttendanceSuccess(),
        ),
      );
    } catch (e, stackTrace) {
      GetIt.I<RecordErrorUseCase>()(RecordErrorParams(
        exception: e,
        stackTrace: stackTrace,
      ));

      emit(
          CancelAttendanceFailure(DefaultServerFailure(message: e.toString())));
    }
  }
}
