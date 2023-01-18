import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'clock_button_type_event.dart';
part 'clock_button_type_state.dart';

class ClockButtonTypeBloc
    extends Bloc<ClockButtonTypeEvent, ClockButtonTypeState> {
  ClockButtonTypeBloc(this.useCase) : super(ClockButtonTypeLoading()) {
    on<ClockButtonTypeFetched>(_onFetch);
  }

  final GetClockButtonTypeUseCase useCase;

  Future _onFetch(
      ClockButtonTypeFetched event, Emitter<ClockButtonTypeState> emit) async {
    try {
      if (state is! ClockButtonTypeSuccess || event.refresh) {
        emit(ClockButtonTypeLoading());
      }

      final result = await useCase(NoParams());

      emit(result.fold(
          (l) => state is ClockButtonTypeSuccess
              ? state
              : ClockButtonTypeFailure(),
          (r) => ClockButtonTypeSuccess(r)));
    } catch (_) {
      emit(ClockButtonTypeFailure());
    }
  }
}
