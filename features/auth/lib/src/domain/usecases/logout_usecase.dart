import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../auth.dart';

class LogOutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logOut();
  }
}
