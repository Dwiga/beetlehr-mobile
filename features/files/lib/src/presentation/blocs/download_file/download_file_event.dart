part of 'download_file_bloc.dart';

abstract class DownloadFileEvent extends Equatable {}

class GetDownloadFileEvent extends DownloadFileEvent {
  final String url;
  final String fileName;
  final String? savePath;
  final bool? showNotification;
  final bool withHttpClient;

  GetDownloadFileEvent({
    required this.url,
    required this.fileName,
    this.savePath,
    this.showNotification,
    this.withHttpClient = false,
  });

  @override
  List<Object?> get props =>
      [url, fileName, savePath, showNotification, withHttpClient];
}
