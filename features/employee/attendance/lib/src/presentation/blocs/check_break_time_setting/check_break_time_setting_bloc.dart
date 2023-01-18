import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'check_break_time_setting_event.dart';
part 'check_break_time_setting_state.dart';

class CheckBreakTimeSettingBloc
    extends Bloc<CheckBreakTimeSettingEvent, CheckBreakTimeSettingState> {
  final GetCheckBreakTimeSettingUseCase useCase;
  CheckBreakTimeSettingBloc(this.useCase)
      : super(CheckBreakTimeSettingInitial());

  @override
  Stream<CheckBreakTimeSettingState> mapEventToState(
    CheckBreakTimeSettingEvent event,
  ) async* {
    if (event is FetchCheckBreakTimeSettingEvent) {
      yield* _mapFetchCheckBreakTimeSetting(event);
    }
  }

  Stream<CheckBreakTimeSettingState> _mapFetchCheckBreakTimeSetting(
      CheckBreakTimeSettingEvent event) async* {
    try {
      yield CheckBreakTimeSettingLoading();
      final result = await useCase(NoParams());

      yield* result.fold((l) async* {
        yield CheckBreakTimeSettingFailure(l);
      }, (r) async* {
        yield CheckBreakTimeSettingSuccess(
          isCanClosePage: r,
        );
      });
    } catch (e) {
      yield CheckBreakTimeSettingFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
