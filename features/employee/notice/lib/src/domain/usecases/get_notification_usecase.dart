import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetNotificationUseCase
    implements
        UseCase<PaginateData<List<NotificationEntity>, MetaData>,
            NotificationsParams> {
  final NoticeRepository repository;

  GetNotificationUseCase(this.repository);
  @override
  Future<Either<Failure, PaginateData<List<NotificationEntity>, MetaData>>>
      call(NotificationsParams params) async {
    return await repository.getNotification();
  }
}

class NotificationsParams {
  final int perPage;
  final int page;

  NotificationsParams({
    required this.perPage,
    required this.page,
  });
}
