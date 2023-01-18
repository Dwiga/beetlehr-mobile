import 'package:dependencies/dependencies.dart';
import 'package:core/core.dart';

import '../../../settings.dart';

abstract class ServerRepository {
  Future<Either<Failure, CheckServerModel>> getSereverStatus(
      String domain, BaseUrlSchema schema);

  Future<Either<Failure, bool>> setSavedServerInfo(CheckServerModel server);

  Future<Either<Failure, CheckServerModel?>> getSavedServerInfo();

  Future<Either<Failure, bool>> removeSavedServerInfo();
}
