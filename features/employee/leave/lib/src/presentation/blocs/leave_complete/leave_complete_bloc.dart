// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';

part 'leave_complete_event.dart';
part 'leave_complete_state.dart';

class LeaveCompleteBloc extends Bloc<LeaveCompleteEvent, LeaveCompleteState> {
  final GetLeavesUseCase useCase;
  LeaveCompleteBloc(this.useCase) : super(LeaveCompleteInitial());

  @override
  Stream<Transition<LeaveCompleteEvent, LeaveCompleteState>> transformEvents(
      Stream<LeaveCompleteEvent> events,
      TransitionFunction<LeaveCompleteEvent, LeaveCompleteState> transitionFn) {
    if (events is FetchLeaveCompleteEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<LeaveCompleteState> mapEventToState(
    LeaveCompleteEvent event,
  ) async* {
    if (event is FetchLeaveCompleteEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield LeaveCompleteInitial();
        }
        if (state is LeaveCompleteSuccess) {
          final currentState = state as LeaveCompleteSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchByCategoryToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchByCategoryToState(event);
        }
      }
    }
  }

  Stream<LeaveCompleteState> _mapFetchByCategoryToState(
      FetchLeaveCompleteEvent event) async* {
    final currentState = state;
    try {
      final _result = await useCase(LeavesParams(
        isComplete: true,
        page: event.page,
        perPage: event.perPage,
      ));

      yield* _result.fold((l) async* {
        if (event.page == 1) {
          yield LeaveCompleteFailure(l);
        }
      }, (r) async* {
        if (currentState is LeaveCompleteInitial || event.page == 1) {
          yield LeaveCompleteSuccess(
            quota: r.quota,
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is LeaveCompleteSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield LeaveCompleteSuccess(
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

  bool _hasReachedMax(LeaveCompleteState state) =>
      state is LeaveCompleteSuccess && state.hasReachedMax;
}
