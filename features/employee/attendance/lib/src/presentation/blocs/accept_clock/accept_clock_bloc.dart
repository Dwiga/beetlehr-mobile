import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'accept_clock_event.dart';
part 'accept_clock_state.dart';

class AcceptClockBloc extends Bloc<AcceptClockEvent, AcceptClockState> {
  final CheckAcceptClockUseCase useCase;
  AcceptClockBloc(this.useCase) : super(AcceptClockInitial());

  @override
  Stream<AcceptClockState> mapEventToState(
    AcceptClockEvent event,
  ) async* {
    if (event is GetCheckAcceptClockEvent) {
      yield* _mapCheckAcceptClockToState(event);
    }
  }

  Stream<AcceptClockState> _mapCheckAcceptClockToState(
      GetCheckAcceptClockEvent event) async* {
    try {
      yield AcceptClockLoading();
      final result = await useCase(event.data);

      yield* result.fold(
        (l) async* {
          yield AcceptClockFailure(l);
        },
        (r) async* {
          yield AcceptClockSuccess(r);
        },
      );
    } catch (e) {
      yield AcceptClockFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
