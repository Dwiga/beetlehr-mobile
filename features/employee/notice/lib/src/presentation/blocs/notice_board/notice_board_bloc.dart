import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

part 'notice_board_event.dart';
part 'notice_board_state.dart';

class NoticeBoardBloc extends Bloc<NoticeBoardEvent, NoticeBoardState> {
  final GetNoticeBoardUseCase getNoticeBoardUseCase;

  NoticeBoardBloc({required this.getNoticeBoardUseCase})
      : super(NoticeBoardLoading());

  @override
  Stream<NoticeBoardState> mapEventToState(
    NoticeBoardEvent event,
  ) async* {
    if (event is FetchNoticeBoardEvent) {
      yield* _mapFetchNoticeBoardToState(event, state);
    }
  }

  Stream<NoticeBoardState> _mapFetchNoticeBoardToState(
    FetchNoticeBoardEvent event,
    NoticeBoardState state,
  ) async* {
    try {
      final _currentState = state;

      if (_currentState is NoticeBoardSuccess && event.refresh != true) {
        return;
      } else {
        yield NoticeBoardLoading();
      }

      final result = await getNoticeBoardUseCase(PaginateParams(
        page: event.page,
        perPage: event.perPage,
      ));

      yield* result.fold((l) async* {
        if (_currentState is! NoticeBoardSuccess) {
          yield NoticeBoardFailure(l);
        } else {
          yield _currentState;
        }
      }, (r) async* {
        yield NoticeBoardSuccess(data: r.data);
      });
    } catch (e) {
      yield NoticeBoardFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
