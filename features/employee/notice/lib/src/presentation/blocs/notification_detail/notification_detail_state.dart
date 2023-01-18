part of 'notification_detail_bloc.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState();
}

class NotificationDetailLoading extends NotificationDetailState {
  @override
  List<Object> get props => [];
}

class NotificationDetailSuccess extends NotificationDetailState {
  final NotificationDetailEntity data;

  const NotificationDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class NotificationDetailFailure extends NotificationDetailState {
  final Failure failure;

  const NotificationDetailFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
