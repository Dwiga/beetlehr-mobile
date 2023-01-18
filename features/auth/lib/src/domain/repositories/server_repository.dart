import 'package:dependencies/dependencies.dart';
import 'package:core/core.dart';

import '../../../auth.dart';

abstract class ServerRepository {
  Future<Either<Failure, ServerModel>> getSereverStatus(
      String endpoint, String protocol);
}
