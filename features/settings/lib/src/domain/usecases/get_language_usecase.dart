import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class GetLanguageUseCase implements UseCase<Country, NoParams> {
  final LanguageRepository repository;

  GetLanguageUseCase(this.repository);

  @override
  Future<Either<Failure, Country>> call(NoParams params) async {
    return await repository.getLanguage();
  }
}
