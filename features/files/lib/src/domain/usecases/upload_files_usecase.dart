import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../files.dart';

class UploadFilesUseCase
    implements UseCase<List<NetworkFileEntity>, List<File>> {
  final FilesRepository repository;

  UploadFilesUseCase(this.repository);

  @override
  Future<Either<Failure, List<NetworkFileEntity>>> call(
      List<File> params) async {
    return await repository.uploadFiles(params);
  }
}
