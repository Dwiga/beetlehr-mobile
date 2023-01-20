// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'all_approval_request_event.dart';
part 'all_approval_request_state.dart';

class AllAppprovalRequestBloc
    extends Bloc<AllApprovalRequestEvent, AllApprovalRequestState> {
  final GetApprovalRequestUseCase getApprovalRequestUseCase;

  AllAppprovalRequestBloc({required this.getApprovalRequestUseCase})
      : super(AllApprovalRequestLoading());

  @override
  Stream<Transition<AllApprovalRequestEvent, AllApprovalRequestState>>
      transformEvents(
          Stream<AllApprovalRequestEvent> events,
          TransitionFunction<AllApprovalRequestEvent, AllApprovalRequestState>
              transitionFn) {
    if (events is FetchAllApprovalRequestEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<AllApprovalRequestState> mapEventToState(
    AllApprovalRequestEvent event,
  ) async* {
    if (event is FetchAllApprovalRequestEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield AllApprovalRequestLoading();
        }
        if (state is AllApprovalRequestSuccess) {
          final currentState = state as AllApprovalRequestSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchAllApprovalRequestToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchAllApprovalRequestToState(event);
        }
      }
    }
  }

  Stream<AllApprovalRequestState> _mapFetchAllApprovalRequestToState(
    FetchAllApprovalRequestEvent event,
  ) async* {
    try {
      var currentState = state;
      final result = await getApprovalRequestUseCase(ApprovalRequestParams(
          perPage: event.perPage,
          page: event.page,
          orderBy: event.sortBy.toString(),
          startTime: event.startTime,
          endTime: event.endTime,
          status: event.status));

      yield* result.fold((l) async* {
        yield AllApprovalRequestFailure(l);
      }, (r) async* {
        if (currentState is AllApprovalRequestLoading || event.page == 1) {
          yield AllApprovalRequestSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is AllApprovalRequestSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield AllApprovalRequestSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } catch (e) {
      yield AllApprovalRequestFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }

  bool _hasReachedMax(AllApprovalRequestState state) =>
      state is AllApprovalRequestSuccess && state.hasReachedMax;
}
