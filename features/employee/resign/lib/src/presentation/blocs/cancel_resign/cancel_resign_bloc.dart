import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../resign.dart';

part 'cancel_resign_event.dart';
part 'cancel_resign_state.dart';

class CancelResignBloc extends Bloc<CancelResignEvent, CancelResignState> {
  final CancelResignUseCase useCase;
  CancelResignBloc(this.useCase) : super(CancelResignInitial());

  @override
  Stream<CancelResignState> mapEventToState(
    CancelResignEvent event,
  ) async* {
    if (event is GetCancelResignEvent) {
      yield* _mapGetCancelToState(event);
    }
  }

  Stream<CancelResignState> _mapGetCancelToState(
      GetCancelResignEvent event) async* {
    try {
      yield CancelResignLoading();

      final result = await useCase(event.id);

      yield result.fold(
        (l) => CancelResignFailure(l),
        (r) => CancelResignSuccess(),
      );
    } catch (e) {
      yield CancelResignFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
