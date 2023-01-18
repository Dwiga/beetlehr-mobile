// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'all_notice_board_event.dart';
part 'all_notice_board_state.dart';

class AllNoticeBoardBloc
    extends Bloc<AllNoticeBoardEvent, AllNoticeBoardState> {
  final GetNoticeBoardUseCase getNoticeBoardUseCase;

  AllNoticeBoardBloc({required this.getNoticeBoardUseCase})
      : super(AllNoticeBoardLoading());

  @override
  Stream<Transition<AllNoticeBoardEvent, AllNoticeBoardState>> transformEvents(
      Stream<AllNoticeBoardEvent> events,
      TransitionFunction<AllNoticeBoardEvent, AllNoticeBoardState>
          transitionFn) {
    if (events is FetchAllNoticeBoardEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<AllNoticeBoardState> mapEventToState(
    AllNoticeBoardEvent event,
  ) async* {
    if (event is FetchAllNoticeBoardEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield AllNoticeBoardLoading();
        }
        if (state is AllNoticeBoardSuccess) {
          final currentState = state as AllNoticeBoardSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchAllNoticeBoardToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchAllNoticeBoardToState(event);
        }
      }
    }
  }

  Stream<AllNoticeBoardState> _mapFetchAllNoticeBoardToState(
    FetchAllNoticeBoardEvent event,
  ) async* {
    try {
      var currentState = state;
      final result = await getNoticeBoardUseCase(PaginateParams(
        page: event.page,
        perPage: event.perPage,
      ));

      yield* result.fold((l) async* {
        yield AllNoticeBoardFailure(l);
      }, (r) async* {
        if (currentState is AllNoticeBoardLoading || event.page == 1) {
          yield AllNoticeBoardSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is AllNoticeBoardSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield AllNoticeBoardSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } catch (e) {
      yield AllNoticeBoardFailure(DefaultServerFailure(message: e.toString()));
    }
  }

  bool _hasReachedMax(AllNoticeBoardState state) =>
      state is AllNoticeBoardSuccess && state.hasReachedMax;
}
