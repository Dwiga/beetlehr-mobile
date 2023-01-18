part of 'notification_detail_bloc.dart';

abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();
}

class FetchNotificationDetailEvent extends NotificationDetailEvent {
  final int id;

  const FetchNotificationDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
