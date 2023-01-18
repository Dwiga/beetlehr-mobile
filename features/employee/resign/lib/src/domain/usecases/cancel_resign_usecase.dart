import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../resign.dart';

class CancelResignUseCase implements UseCase<bool, int> {
  final ResignRepository repository;

  CancelResignUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.cancelResign(params);
  }
}
