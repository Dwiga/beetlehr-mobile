import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'clock_offline_button_type_event.dart';

class ClockOfflineButtonTypeBloc
    extends Bloc<ClockOfflineButtonTypeEvent, ClockOfflineButtonTypeState> {
  ClockOfflineButtonTypeBloc(this.useCase)
      : super(const ClockOfflineButtonTypeState(type: ClockButtonType.none)) {
    on<ClockOfflineButtonTypeFetched>(_onFetch);
  }

  final GetTodaySavedAttendanceUseCase useCase;

  Future _onFetch(ClockOfflineButtonTypeFetched event,
      Emitter<ClockOfflineButtonTypeState> emit) async {
    try {
      final result = await useCase(NoParams());

      emit(
        result.fold(
          (l) {
            if (l is NotFoundCacheFailure) {
              return state.copyWith(
                type: ClockButtonType.clockIn,
              );
            } else {
              return state;
            }
          },
          (data) {
            if (data.clockIn != null && data.clockOut == null) {
              return state.copyWith(
                type: ClockButtonType.clockOut,
                workingFrom: data.clockIn!.workFrom,
              );
            }

            return state.copyWith(type: ClockButtonType.none);
          },
        ),
      );
    } catch (_) {}
  }
}

class ClockOfflineButtonTypeState extends Equatable {
  final ClockButtonType type;
  final WorkingFromType? workingFrom;

  const ClockOfflineButtonTypeState({
    required this.type,
    this.workingFrom,
  });

  ClockOfflineButtonTypeState copyWith({
    ClockButtonType? type,
    WorkingFromType? workingFrom,
  }) {
    return ClockOfflineButtonTypeState(
      type: type ?? this.type,
      workingFrom: workingFrom ?? this.workingFrom,
    );
  }

  @override
  List<Object?> get props => [type, workingFrom];
}
