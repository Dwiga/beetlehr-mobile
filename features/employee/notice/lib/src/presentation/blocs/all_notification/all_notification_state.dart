part of 'all_notification_bloc.dart';

abstract class AllNotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllNotificationLoading extends AllNotificationState {}

class AllNotificationFailure extends AllNotificationState {
  final Failure failure;
  AllNotificationFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AllNotificationSuccess extends AllNotificationState {
  final List<NotificationEntity> data;
  final bool hasReachedMax;
  final int page;

  AllNotificationSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];
}
