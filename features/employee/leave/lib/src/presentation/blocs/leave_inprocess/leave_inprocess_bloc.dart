// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';

part 'leave_inprocess_event.dart';
part 'leave_inprocess_state.dart';

class LeaveInProcessBloc
    extends Bloc<LeaveInProcessEvent, LeaveInProcessState> {
  final GetLeavesUseCase useCase;
  LeaveInProcessBloc(this.useCase) : super(LeaveInProcessInitial());
  @override
  Stream<Transition<LeaveInProcessEvent, LeaveInProcessState>> transformEvents(
      Stream<LeaveInProcessEvent> events,
      TransitionFunction<LeaveInProcessEvent, LeaveInProcessState>
          transitionFn) {
    if (events is FetchLeaveInProcessEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<LeaveInProcessState> mapEventToState(
    LeaveInProcessEvent event,
  ) async* {
    if (event is FetchLeaveInProcessEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield LeaveInProcessInitial();
        }
        if (state is LeaveInProcessSuccess) {
          final currentState = state as LeaveInProcessSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchByCategoryToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchByCategoryToState(event);
        }
      }
    }
  }

  Stream<LeaveInProcessState> _mapFetchByCategoryToState(
      FetchLeaveInProcessEvent event) async* {
    final currentState = state;
    try {
      final _result = await useCase(LeavesParams(
        isComplete: false,
        page: event.page,
        perPage: event.perPage,
      ));

      yield* _result.fold((l) async* {
        if (event.page == 1) {
          yield LeaveInProcessFailure(l);
        }
      }, (r) async* {
        if (currentState is LeaveInProcessInitial || event.page == 1) {
          yield LeaveInProcessSuccess(
            quota: r.quota,
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is LeaveInProcessSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield LeaveInProcessSuccess(
            quota: currentState.quota,
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } on Exception catch (_) {}
  }

  bool _hasReachedMax(LeaveInProcessState state) =>
      state is LeaveInProcessSuccess && state.hasReachedMax;
}
