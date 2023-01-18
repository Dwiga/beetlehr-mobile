import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'approve_request_event.dart';
part 'approve_request_state.dart';

class ApproveRequestBloc
    extends Bloc<ApproveRequestEvent, ApproveRequestState> {
  final ApproveRequestUseCase useCase;
  ApproveRequestBloc(this.useCase) : super(ApproveRequestInitial());

  @override
  Stream<ApproveRequestState> mapEventToState(
    ApproveRequestEvent event,
  ) async* {
    if (event is FetchApproveRequestEvent) {
      yield* _mapFetchApproveRequest(event);
    }
  }

  Stream<ApproveRequestState> _mapFetchApproveRequest(
      FetchApproveRequestEvent event) async* {
    try {
      yield ApproveRequestLoading();
      final result =
          await useCase(ApproveResponseParams(id: event.id, body: event.body));

      yield* result.fold((l) async* {
        yield ApproveRequestFailure(l);
      }, (r) async* {
        yield ApproveRequestSuccess(r);
      });
    } catch (e) {
      yield ApproveRequestFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
