import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetApprovalRequestDetailUseCase
    implements
        UseCase<ApprovalRequestDetailEntity, ApprovalRequestDetailParams> {
  final NoticeRepository repository;

  GetApprovalRequestDetailUseCase(this.repository);
  @override
  Future<Either<Failure, ApprovalRequestDetailEntity>> call(
      ApprovalRequestDetailParams params) async {
    return await repository.getApprovalRequestDetail(params.id, params.type);
  }
}

class ApprovalRequestDetailParams {
  final int id;
  final String type;

  ApprovalRequestDetailParams(this.id, this.type);
}
