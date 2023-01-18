import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../resign.dart';

class CreateResignUseCase implements UseCase<ResignEntity, ResignBodyModel> {
  final ResignRepository repository;

  CreateResignUseCase(this.repository);
  @override
  Future<Either<Failure, ResignEntity>> call(ResignBodyModel params) async {
    return await repository.createResign(params);
  }
}
