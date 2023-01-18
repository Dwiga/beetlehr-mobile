import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../files.dart';

abstract class FilesRepository {
  Future<Either<Failure, List<NetworkFileEntity>>> uploadFiles(
      List<File> files);

  Future<Either<Failure, List<NetworkFileEntity>>> uploadAnyFiles(
      List<File> files);

  Future<Either<Failure, String>> downloadFile(String url, String savePath);
}
