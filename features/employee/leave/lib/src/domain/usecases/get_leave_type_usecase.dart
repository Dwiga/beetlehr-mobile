import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../leave.dart';

class GetLeaveTypeUseCase
    implements
        UseCase<PaginateData<List<LeaveTypeEntity>, MetaData>, PaginateParams> {
  final LeaveRepository repository;

  GetLeaveTypeUseCase(this.repository);
  @override
  Future<Either<Failure, PaginateData<List<LeaveTypeEntity>, MetaData>>> call(
      PaginateParams params) async {
    return await repository.getLeaveType(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
