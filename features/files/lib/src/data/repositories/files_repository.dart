import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../files.dart';
import '../../utils/utils.dart';

class FilesRepositoryImpl implements FilesRepository {
  final FilesApiDataSource apiDataSource;

  FilesRepositoryImpl(this.apiDataSource);

  @override
  Future<Either<Failure, String>> downloadFile(
      String url, String savePath) async {
    try {
      await apiDataSource.downloadFile(url, savePath);

      return Right(savePath);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, List<NetworkFileEntity>>> uploadFiles(
      List<File> files) async {
    try {
      final result = await apiDataSource.uploadFiles(files.toFormData());

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }

  @override
  Future<Either<Failure, List<NetworkFileEntity>>> uploadAnyFiles(
      List<File> files) async {
    try {
      final result = await apiDataSource.uploadAnyFiles(files.toFormData());

      return Right(result.data);
    } on ServerException catch (e) {
      return Left(NetworkUtils.serverExceptionToFailure(e)!);
    }
  }
}
