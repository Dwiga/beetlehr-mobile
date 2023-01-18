import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../data/data.dart';
import '../domain.dart';

abstract class ResignRepository {
  Future<Either<Failure, ResignEntity>> createResign(ResignBodyModel body);

  Future<Either<Failure, ResignEntity?>> getResign();

  Future<Either<Failure, bool>> cancelResign(int id);
}
