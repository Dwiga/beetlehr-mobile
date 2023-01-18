import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart' hide Option;
import 'package:dio/dio.dart';

import '../../../files.dart';

abstract class FilesApiDataSource {
  Future<UploadFilesResponseModel> uploadFiles(FormData data);

  Future<UploadFilesResponseModel> uploadAnyFiles(FormData data);

  Future<bool> downloadFile(String url, String savePath);
}

class FilesApiDataSourceImpl implements FilesApiDataSource {
  final Dio client;

  FilesApiDataSourceImpl(this.client);

  @override
  Future<bool> downloadFile(String url, String savePath) async {
    try {
      await client.download(
        url,
        savePath,
        deleteOnError: true,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Connection': 'keep-alive',
            'unAuthorize': true,
          },
        ),
        onReceiveProgress: (a, b) {},
      );

      return true;
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<UploadFilesResponseModel> uploadFiles(FormData data) async {
    try {
      final response = await client.post('/employee/files', data: data);

      return UploadFilesResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }

  @override
  Future<UploadFilesResponseModel> uploadAnyFiles(FormData data) async {
    try {
      final response =
          await client.post('/employee/optional-files', data: data);

      return UploadFilesResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw await NetworkUtils.dioErrorToException(e);
    }
  }
}
