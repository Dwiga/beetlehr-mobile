import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../leave.dart';

abstract class LeaveRepository {
  Future<Either<Failure, LeaveResponseModel>> getLeaves(
      {required bool isComplete, required int page, required int perPage});

  Future<Either<Failure, LeaveDetailEntity>> getDetailLeave(int id);

  Future<Either<Failure, PaginateData<List<LeaveTypeEntity>, MetaData>>>
      getLeaveType({required int page, required int perPage});

  Future<Either<Failure, bool>> createLeave(LeaveBodyModel body);

  Future<Either<Failure, bool>> cancelLeave(int id);
}
