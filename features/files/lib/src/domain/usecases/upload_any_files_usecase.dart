import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../files.dart';

class UploadAnyFilesUseCase
    implements UseCase<List<NetworkFileEntity>, List<File>> {
  final FilesRepository repository;

  UploadAnyFilesUseCase(this.repository);

  @override
  Future<Either<Failure, List<NetworkFileEntity>>> call(
      List<File> params) async {
    return await repository.uploadAnyFiles(params);
  }
}
