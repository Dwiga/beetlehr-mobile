part of 'all_notification_bloc.dart';

abstract class AllNotificationEvent extends Equatable {}

class FetchAllNotificationEvent extends AllNotificationEvent {
  final int perPage;
  final int page;

  FetchAllNotificationEvent({required this.perPage, required this.page});

  @override
  List<Object?> get props => [perPage, page];

  @override
  bool get stringify => true;
}
