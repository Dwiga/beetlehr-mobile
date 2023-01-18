import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../settings.dart';

class SetBaseUrlUseCase implements UseCase<bool, SetBaseUrlParams> {
  final SettingRepository repository;

  SetBaseUrlUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetBaseUrlParams params) async {
    try {
      final formatUrl = '${params.schema.toUrlSchema()}://${params.domain}';
      final url = Uri.tryParse(formatUrl);

      if (url == null || url.host.isEmpty) {
        return const Left(DefaultServerFailure(message: 'URL is invalid'));
      }

      return repository.setBaseURL(
        Uri(scheme: url.scheme, host: url.host, path: '/api/v1'),
      );
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}

class SetBaseUrlParams extends Equatable {
  final String domain;
  final BaseUrlSchema schema;

  const SetBaseUrlParams({required this.domain, required this.schema});

  @override
  List<Object?> get props => [domain, schema];
}

enum BaseUrlSchema { http, https }

extension BaseUrlSchemaX on BaseUrlSchema {
  String toUrlSchema() {
    switch (this) {
      case BaseUrlSchema.http:
        return 'http';
      case BaseUrlSchema.https:
        return 'https';
    }
  }
}
