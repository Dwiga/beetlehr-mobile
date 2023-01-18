import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileBodyModel body);
}
