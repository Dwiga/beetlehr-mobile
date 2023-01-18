import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class DeleteBaseUrlUseCase implements UseCase<bool, NoParams> {
  final SettingRepository repository;

  DeleteBaseUrlUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.deleteBaseURL();
  }
}
