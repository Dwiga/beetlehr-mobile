import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../attendance.dart';

class GetCheckPlacementOfficeUseCase
    implements UseCase<OfficePlacementEntity, CheckPlacementBodyModel> {
  final AttendanceRepository repository;

  GetCheckPlacementOfficeUseCase(this.repository);
  @override
  Future<Either<Failure, OfficePlacementEntity>> call(
      CheckPlacementBodyModel params) async {
    return await repository.checkPlacementOffice(params.toJson());
  }
}
