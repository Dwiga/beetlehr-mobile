import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'pending_attendances_event.dart';
part 'pending_attendances_state.dart';

class PendingAttendancesBloc
    extends Bloc<PendingAttendancesEvent, PendingAttendancesState> {
  PendingAttendancesBloc(this.useCase) : super(PendingAttendancesLoading()) {
    on<PendingAttendancesFetched>(_onFetch);
  }

  final GetSavedAttendancesUseCase useCase;

  Future _onFetch(PendingAttendancesFetched event,
      Emitter<PendingAttendancesState> emit) async {
    try {
      if (state is PendingAttendancesSuccess && event.refresh) {
        emit(PendingAttendancesLoading());
      }

      final result = await useCase(NoParams());

      emit(
        result.fold(
          (l) => state is PendingAttendancesSuccess
              ? state
              : PendingAttendancesFailure(l),
          (r) => PendingAttendancesSuccess(r.reversed.toList()
              // Remove Saved Attendance Online Attendance
              // when attendace is not today
              // ..removeWhere(
              //   (element) =>
              //       !element.date.isToday() &&
              //       ((element.clockIn?.isSynced ?? false) &&
              //           (element.clockOut?.isSynced ?? false)),
              // ),
              ),
        ),
      );
    } catch (_) {
      emit(PendingAttendancesFailure(CacheFailure(message: _.toString())));
    }
  }
}
