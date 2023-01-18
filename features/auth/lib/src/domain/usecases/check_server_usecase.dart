import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../auth.dart';

class CheckServerUseCase implements UseCase<ServerModel, ServerParams> {
  final ServerRepository repository;

  CheckServerUseCase(this.repository);

  @override
  Future<Either<Failure, ServerModel>> call(ServerParams params) async {
    return await repository.getSereverStatus(params.endpoint, params.protocol);
  }
}

class ServerParams {
  final String endpoint;
  final String protocol;
  ServerParams({required this.endpoint, required this.protocol});
}
