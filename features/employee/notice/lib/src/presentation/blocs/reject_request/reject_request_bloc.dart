import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'reject_request_event.dart';
part 'reject_request_state.dart';

class RejectRequestBloc extends Bloc<RejectRequestEvent, RejectRequestState> {
  final RejectRequestUseCase useCase;
  RejectRequestBloc(this.useCase) : super(RejectRequestInitial());

  @override
  Stream<RejectRequestState> mapEventToState(
    RejectRequestEvent event,
  ) async* {
    if (event is FetchRejectRequestEvent) {
      yield* _mapFetchRejectRequest(event);
    }
  }

  Stream<RejectRequestState> _mapFetchRejectRequest(
      FetchRejectRequestEvent event) async* {
    try {
      yield RejectRequestLoading();
      final result =
          await useCase(RejectResponseParams(id: event.id, body: event.body));

      yield* result.fold((l) async* {
        yield RejectRequestFailure(l);
      }, (r) async* {
        yield RejectRequestSuccess(r);
      });
    } catch (e) {
      yield RejectRequestFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
