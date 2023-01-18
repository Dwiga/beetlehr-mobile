import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/services.dart';

import '../../../files.dart';

class SaveFileDownloadFolderUseCase
    implements UseCase<bool, SaveFileDownloadFolderParams> {
  final FilesRepository repository;

  SaveFileDownloadFolderUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      SaveFileDownloadFolderParams params) async {
    try {
      var defaultPath = '';

      // Get Download Folder
      var permissionStatus = await Permission.storage.status;

      if (!permissionStatus.isGranted) {
        await Permission.storage.request();
      }

      var _basePath = await _getBasePath();
      final savedDir = Directory(_basePath ?? '');
      var hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      defaultPath = savedDir.path;

      defaultPath += '${Platform.pathSeparator}${params.fileName}';

      // save the data in the path
      final result = await File(defaultPath).writeAsBytes(params.data);

      if (params.openOnSuccess ?? false) {
        await OpenFile.open(defaultPath);
      }

      return Right(await result.exists());
    } on PlatformException catch (e) {
      return Left(CacheFailure(message: e.message ?? ''));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<String?> _getBasePath() async {
    if (Platform.isAndroid) {
      return GetIt.I<FilesDeviceDataSource>().getDownloadFolderPath();
    }

    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class SaveFileDownloadFolderParams {
  final Uint8List data;
  final String fileName;
  final bool? openOnSuccess;

  SaveFileDownloadFolderParams(
    this.data, {
    required this.fileName,
    this.openOnSuccess,
  });
}
