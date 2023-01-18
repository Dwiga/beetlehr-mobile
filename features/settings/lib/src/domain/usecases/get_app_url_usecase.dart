import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../settings.dart';

class GetAppUrlUseCase implements UseCase<String, NoParams> {
  final RemoteConfigService remoteConfigService;

  GetAppUrlUseCase(this.remoteConfigService);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    try {
      if (Platform.isIOS) {
        final configValue =
            await remoteConfigService.getValue('apps_store_url');
        if (configValue != null) {
          return Right(configValue.asString());
        }
      } else {
        final configValue =
            await remoteConfigService.getValue('play_store_url');

        if (configValue != null) {
          return Right(configValue.asString());
        }
      }
    } catch (exception) {
      return Left(DefaultServerFailure(message: exception.toString()));
    }
    return const Left(DefaultServerFailure(message: ''));
  }
}
