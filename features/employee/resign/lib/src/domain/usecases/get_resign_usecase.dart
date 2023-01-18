import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../resign.dart';

class GetResignUseCase implements UseCase<ResignEntity?, NoParams> {
  final ResignRepository repository;

  GetResignUseCase(this.repository);
  @override
  Future<Either<Failure, ResignEntity?>> call(NoParams params) async {
    return await repository.getResign();
  }
}
