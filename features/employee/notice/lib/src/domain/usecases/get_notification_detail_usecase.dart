import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetNotificationDetailUseCase
    implements UseCase<NotificationDetailEntity, NotificationDetailParams> {
  final NoticeRepository repository;

  GetNotificationDetailUseCase(this.repository);
  @override
  Future<Either<Failure, NotificationDetailEntity>> call(
      NotificationDetailParams params) async {
    return await repository.getNotificationDetail(params.id);
  }
}

class NotificationDetailParams {
  final int id;

  NotificationDetailParams(this.id);
}
