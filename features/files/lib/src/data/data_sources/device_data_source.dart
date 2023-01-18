// ignore: one_member_abstracts
import 'package:flutter/services.dart';

// ignore: one_member_abstracts
abstract class FilesDeviceDataSource {
  Future<String?> getDownloadFolderPath();
}

class FilesDeviceDataSourceImpl implements FilesDeviceDataSource {
  static const _channel = MethodChannel('mobile.trackingworks.io');

  @override
  Future<String?> getDownloadFolderPath() async {
    final String version = await _channel.invokeMethod('download_folder_path');
    return version;
  }
}
