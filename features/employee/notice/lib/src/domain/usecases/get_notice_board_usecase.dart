import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetNoticeBoardUseCase
    implements
        UseCase<PaginateData<List<NoticeEntity>, MetaData>, PaginateParams> {
  final NoticeRepository repository;

  GetNoticeBoardUseCase(this.repository);
  @override
  Future<Either<Failure, PaginateData<List<NoticeEntity>, MetaData>>> call(
      PaginateParams params) async {
    return await repository.getNoticeBoard(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
