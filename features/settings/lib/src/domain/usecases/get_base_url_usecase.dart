import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dependencies/dependencies.dart';

import '../../../settings.dart';

class GetBaseUrlUseCase implements UseCase<Uri?, NoParams> {
  final SettingRepository repository;

  GetBaseUrlUseCase(this.repository);

  @override
  Future<Either<Failure, Uri?>> call(NoParams params) {
    return repository.getBaseURL();
  }
}
