import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../leave.dart';

class GetLeavesUseCase implements UseCase<LeaveResponseModel, LeavesParams> {
  final LeaveRepository repository;

  GetLeavesUseCase(this.repository);
  @override
  Future<Either<Failure, LeaveResponseModel>> call(LeavesParams params) async {
    return await repository.getLeaves(
      isComplete: params.isComplete,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class LeavesParams {
  final bool isComplete;
  final int page;
  final int perPage;
  LeavesParams({
    this.isComplete = false,
    required this.page,
    required this.perPage,
  });
}
