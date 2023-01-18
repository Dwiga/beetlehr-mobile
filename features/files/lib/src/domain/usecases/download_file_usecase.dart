import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/services.dart';

import '../../../files.dart';

class DownloadFileUseCase implements UseCase<String, DownloadFileParams> {
  final FilesRepository repository;

  DownloadFileUseCase(this.repository);

  static void initialize() async {
    await FlutterDownloader.initialize();

    var _receivePort = ReceivePort();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    FlutterDownloader.registerCallback(_downloadingCallback);
  }

  static void _downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    var sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }

  @override
  Future<Either<Failure, String>> call(DownloadFileParams params) async {
    try {
      // Get Download Folder
      var permissionStatus = await Permission.storage.status;

      if (!permissionStatus.isGranted) {
        await Permission.storage.request();
      }

      String _basePath;
      if (params.savePath != null) {
        final splitDir = params.savePath!.split(Platform.pathSeparator);
        splitDir.removeLast();

        final directory = Directory(splitDir.join());

        if (await directory.exists()) {
          _basePath = params.savePath!;
        } else {
          _basePath = (await _getBasePath()) ?? '';
        }
      } else {
        var _targetPath = await _getBasePath();
        _basePath = _targetPath ?? '';
        if (_targetPath == null) {
          _basePath = (await getApplicationDocumentsDirectory()).path;
        }
      }

      final savedDir = Directory(_basePath);
      final hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      var saveFileName = params.fileName;

      if (await File(savedDir.path + Platform.pathSeparator + params.fileName)
          .exists()) {
        var fileExtension = '';
        var splitFileName = saveFileName.split('.');
        if (splitFileName.isNotEmpty) {
          fileExtension = splitFileName.last;
          splitFileName.remove(fileExtension);
          saveFileName = splitFileName.join();
        }

        saveFileName += '_1.$fileExtension';
      }

      if (params.withHttpClint == true) {
        return repository.downloadFile(params.url,
            savedDir.path + Platform.pathSeparator + params.fileName);
      }

      final result = await FlutterDownloader.enqueue(
        url: params.url,
        savedDir: savedDir.path,
        fileName: saveFileName,
        openFileFromNotification: true,
        showNotification: params.showNotification,
      );

      var resultPath = '';
      if (result != null && result.trim().isNotEmpty) {
        resultPath = '$result.${params.fileName.split('.').last}';
      } else {
        resultPath = savedDir.path + Platform.pathSeparator + params.fileName;
      }

      return Right(resultPath);
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
    return directory.absolute.path;
  }
}

class DownloadFileParams {
  final String url;
  final String fileName;
  final String? savePath;
  final bool showNotification;
  final bool withHttpClint;

  DownloadFileParams(
    this.url, {
    required this.fileName,
    this.savePath,
    this.showNotification = false,
    this.withHttpClint = false,
  });
}
