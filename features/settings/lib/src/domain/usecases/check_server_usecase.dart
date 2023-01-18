import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

class CheckServerUseCase implements UseCase<CheckServerModel, ServerParams> {
  final ServerRepository repository;

  const CheckServerUseCase(this.repository);

  @override
  Future<Either<Failure, CheckServerModel>> call(ServerParams params) async {
    return await repository.getSereverStatus(params.domain, params.schema);
  }
}

class ServerParams extends Equatable {
  final String domain;
  final BaseUrlSchema schema;

  const ServerParams({required this.domain, required this.schema});

  @override
  List<Object?> get props => [domain, schema];
}
