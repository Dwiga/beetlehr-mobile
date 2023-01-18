import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class SaveTokenUseCase implements UseCase<bool, String> {
  final SettingRepository repository;

  SaveTokenUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.saveToken(params);
  }
}
