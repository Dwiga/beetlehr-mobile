// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final GetPayrollsUseCase useCase;
  PayrollBloc(this.useCase) : super(PayrollInitial());

  @override
  Stream<Transition<PayrollEvent, PayrollState>> transformEvents(
      Stream<PayrollEvent> events,
      TransitionFunction<PayrollEvent, PayrollState> transitionFn) {
    if (events is FetchPayrollEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<PayrollState> mapEventToState(
    PayrollEvent event,
  ) async* {
    if (event is FetchPayrollEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield PayrollInitial();
        }
        if (state is PayrollSuccess) {
          final currentState = state as PayrollSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchByCategoryToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchByCategoryToState(event);
        }
      }
    }
  }

  Stream<PayrollState> _mapFetchByCategoryToState(
      FetchPayrollEvent event) async* {
    final currentState = state;
    try {
      final _result = await useCase(PayrollParams(
        month: event.month,
        year: event.year,
        page: event.page,
        perPage: event.perPage,
      ));

      yield* _result.fold((l) async* {
        if (event.page == 1) {
          yield PayrollFailure(l);
        }
      }, (r) async* {
        if (currentState is PayrollInitial || event.page == 1) {
          yield PayrollSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is PayrollSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield PayrollSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } on Exception catch (_) {}
  }

  bool _hasReachedMax(PayrollState state) =>
      state is PayrollSuccess && state.hasReachedMax;
}
