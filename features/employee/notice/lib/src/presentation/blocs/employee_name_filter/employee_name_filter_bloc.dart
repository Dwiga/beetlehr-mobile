// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'employee_name_filter_event.dart';
part 'employee_name_filter_state.dart';

class EmployeeNameFilterBloc
    extends Bloc<EmployeeNameFilterEvent, EmployeeNameFilterState> {
  final GetEmployeeNameFilterUseCase getEmployeeFilterUseCase;

  EmployeeNameFilterBloc({required this.getEmployeeFilterUseCase})
      : super(EmployeeNameFilterLoading());

  @override
  Stream<Transition<EmployeeNameFilterEvent, EmployeeNameFilterState>>
      transformEvents(
          Stream<EmployeeNameFilterEvent> events,
          TransitionFunction<EmployeeNameFilterEvent, EmployeeNameFilterState>
              transitionFn) {
    if (events is FetchEmployeeNameFilterEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<EmployeeNameFilterState> mapEventToState(
    EmployeeNameFilterEvent event,
  ) async* {
    if (event is FetchEmployeeNameFilterEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield EmployeeNameFilterLoading();
        }
        if (state is EmployeeNameFilterSuccess) {
          final currentState = state as EmployeeNameFilterSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchEmployeeNameFilterToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchEmployeeNameFilterToState(event);
        }
      }
    }
  }

  Stream<EmployeeNameFilterState> _mapFetchEmployeeNameFilterToState(
    FetchEmployeeNameFilterEvent event,
  ) async* {
    try {
      var currentState = state;
      final result = await getEmployeeFilterUseCase(EmployeeNameFilterParams(
          perPage: event.perPage, page: event.page, name: event.name));

      yield* result.fold((l) async* {
        yield EmployeeNameFilterFailure(l);
      }, (r) async* {
        if (currentState is EmployeeNameFilterLoading || event.page == 1) {
          yield EmployeeNameFilterSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is EmployeeNameFilterSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield EmployeeNameFilterSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } catch (e) {
      yield EmployeeNameFilterFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }

  bool _hasReachedMax(EmployeeNameFilterState state) =>
      state is EmployeeNameFilterSuccess && state.hasReachedMax;
}
