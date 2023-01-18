import 'package:dependencies/dependencies.dart';
import 'package:core/core.dart';

// ignore: one_member_abstracts
abstract class SettingRepository {
  Future<Either<Failure, bool>> saveToken(String token);

  Future<Either<Failure, bool>> setBaseURL(Uri uri);

  Future<Either<Failure, Uri?>> getBaseURL();

  Future<Either<Failure, bool>> deleteBaseURL();
}
