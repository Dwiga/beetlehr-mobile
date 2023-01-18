import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../profile.dart';

class UpdateProfileUseCase implements UseCase<ProfileEntity, ProfileBodyModel> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);
  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileBodyModel params) async {
    return await repository.updateProfile(params);
  }
}
