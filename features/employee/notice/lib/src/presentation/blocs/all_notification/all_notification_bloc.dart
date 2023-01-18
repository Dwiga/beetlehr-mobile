// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'all_notification_event.dart';
part 'all_notification_state.dart';

class AllNotificationBloc
    extends Bloc<AllNotificationEvent, AllNotificationState> {
  final GetNotificationUseCase getNotificationUseCase;

  AllNotificationBloc({required this.getNotificationUseCase})
      : super(AllNotificationLoading());

  @override
  Stream<Transition<AllNotificationEvent, AllNotificationState>>
      transformEvents(
          Stream<AllNotificationEvent> events,
          TransitionFunction<AllNotificationEvent, AllNotificationState>
              transitionFn) {
    if (events is FetchAllNotificationEvent) {
      return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)),
        transitionFn,
      );
    } else {
      return super.transformEvents(events, transitionFn);
    }
  }

  @override
  Stream<AllNotificationState> mapEventToState(
    AllNotificationEvent event,
  ) async* {
    if (event is FetchAllNotificationEvent) {
      if (!_hasReachedMax(state) || event.page == 1) {
        if (event.page == 1) {
          yield AllNotificationLoading();
        }
        if (state is AllNotificationSuccess) {
          final currentState = state as AllNotificationSuccess;
          if (event.page == 1 || event.page > currentState.page) {
            yield* _mapFetchAllNotificationToState(event);
          }
        } else if (event.page == 1) {
          yield* _mapFetchAllNotificationToState(event);
        }
      }
    }
  }

  Stream<AllNotificationState> _mapFetchAllNotificationToState(
    FetchAllNotificationEvent event,
  ) async* {
    try {
      var currentState = state;
      final result = await getNotificationUseCase(NotificationsParams(
        perPage: event.perPage,
        page: event.page,
      ));

      yield* result.fold((l) async* {
        yield AllNotificationFailure(l);
      }, (r) async* {
        if (currentState is AllNotificationLoading || event.page == 1) {
          yield AllNotificationSuccess(
            data: r.data,
            hasReachedMax: r.meta?.pagination?.currentPage ==
                r.meta?.pagination?.totalPages,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        } else if (currentState is AllNotificationSuccess &&
            currentState.page < (r.meta?.pagination?.currentPage ?? 0)) {
          yield AllNotificationSuccess(
            data: currentState.data + r.data,
            hasReachedMax: r.meta?.pagination?.totalPages ==
                r.meta?.pagination?.currentPage,
            page: r.meta?.pagination?.currentPage ?? 0,
          );
        }
      });
    } catch (e) {
      yield AllNotificationFailure(DefaultServerFailure(message: e.toString()));
    }
  }

  bool _hasReachedMax(AllNotificationState state) =>
      state is AllNotificationSuccess && state.hasReachedMax;
}
