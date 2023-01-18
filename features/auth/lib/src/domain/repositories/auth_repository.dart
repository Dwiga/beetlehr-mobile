import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../auth.dart';

/// Interface Auth Repository
abstract class AuthRepository {
  ///
  Future<Either<Failure, UserEntity>> loginWithEmail(
      Map<String, dynamic> jsonBody);

  ///
  Future<Either<Failure, UserEntity>> getSavedUser();

  Future<Either<Failure, bool>> setSavedUser(UserModel user);

  ///
  Future<Either<Failure, String>> getSavedToken();

  ///
  Future<Either<Failure, bool>> resetPassword(String email);

  Future<Either<Failure, bool>> logOut();
}
