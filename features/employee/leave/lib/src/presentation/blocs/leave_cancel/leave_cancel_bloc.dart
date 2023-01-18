import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';

part 'leave_cancel_event.dart';
part 'leave_cancel_state.dart';

class LeaveCancelBloc extends Bloc<LeaveCancelEvent, LeaveCancelState> {
  final CancelLeaveUseCase useCase;
  LeaveCancelBloc(this.useCase) : super(LeaveCancelLoading());

  @override
  Stream<LeaveCancelState> mapEventToState(
    LeaveCancelEvent event,
  ) async* {
    if (event is GetLeaveCancelEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<LeaveCancelState> _mapFetchDataToState(
      GetLeaveCancelEvent event) async* {
    try {
      yield LeaveCancelLoading();
      final result = await useCase(event.id);

      yield* result.fold((l) async* {
        yield LeaveCancelFailure(l);
      }, (r) async* {
        yield LeaveCancelSuccess();
      });
    } catch (e) {
      yield LeaveCancelFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
