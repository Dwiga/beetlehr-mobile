import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../../../notice.dart';

part 'notification_detail_event.dart';
part 'notification_detail_state.dart';

class NotificationDetailBloc
    extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  final GetNotificationDetailUseCase getNotificationDetailUseCase;
  NotificationDetailBloc(this.getNotificationDetailUseCase)
      : super(NotificationDetailLoading());

  @override
  Stream<NotificationDetailState> mapEventToState(
    NotificationDetailEvent event,
  ) async* {
    if (event is FetchNotificationDetailEvent) {
      yield* _mapFetchNotificationDetailToState(event);
    }
  }

  Stream<NotificationDetailState> _mapFetchNotificationDetailToState(
      FetchNotificationDetailEvent event) async* {
    try {
      final result = await getNotificationDetailUseCase(
          NotificationDetailParams(event.id));
      yield* result.fold((l) async* {
        yield NotificationDetailFailure(l);
      }, (r) async* {
        yield NotificationDetailSuccess(r);
      });
    } catch (e) {
      yield NotificationDetailFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
