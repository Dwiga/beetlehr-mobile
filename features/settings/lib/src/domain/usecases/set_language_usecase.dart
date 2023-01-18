import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../settings.dart';

class SetLanguageUseCase implements UseCase<bool, LanguageParam> {
  final LanguageRepository repository;

  SetLanguageUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LanguageParam params) async {
    return await repository.setLanguage(params.country);
  }
}

class LanguageParam {
  final CountryModel country;

  LanguageParam(this.country);
}
