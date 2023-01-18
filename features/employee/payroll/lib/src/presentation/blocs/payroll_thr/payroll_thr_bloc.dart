// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

part 'payroll_thr_event.dart';
part 'payroll_thr_state.dart';

class PayrollTHRBloc extends Bloc<PayrollTHREvent, PayrollTHRState> {
  final GetPayrollsTHRUseCase useCase;
  PayrollTHRBloc(this.useCase) : super(PayrollTHRInitial());

  @override
  Stream<Transition<PayrollTHREvent, PayrollTHRState>> transformEvents(
      Stream<PayrollTHREvent> events,
      TransitionFunction<PayrollTHREvent, PayrollTHRState> transitionFn) {
    if (events is FetchPayrollTHREvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<PayrollTHRState> mapEventToState(
    PayrollTHREvent event,
  ) async* {
    if (event is FetchPayrollTHREvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield PayrollTHRInitial();
        }
        if (state is PayrollTHRSuccess) {
          final currentState = state as PayrollTHRSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchByCategoryToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchByCategoryToState(event);
        }
      }
    }
  }

  Stream<PayrollTHRState> _mapFetchByCategoryToState(
      FetchPayrollTHREvent event) async* {
    final currentState = state;
    try {
      final _result = await useCase(PaginateParams(
        page: event.page,
        perPage: event.perPage,
      ));

      yield* _result.fold((l) async* {
        if (event.page == 1) {
          yield PayrollTHRFailure(l);
        }
      }, (r) async* {
        if (currentState is PayrollTHRInitial || event.page == 1) {
          yield PayrollTHRSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is PayrollTHRSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield PayrollTHRSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } on Exception catch (_) {}
  }

  bool _hasReachedMax(PayrollTHRState state) =>
      state is PayrollTHRSuccess && state.hasReachedMax;
}
