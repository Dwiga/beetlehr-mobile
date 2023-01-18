import 'package:dependencies/dependencies.dart';

class NetworkFileEntity extends Equatable {
  NetworkFileEntity({
    required this.id,
    required this.url,
    this.fileName,
    this.extensionFile,
    this.size,
  });

  final int id;
  final String url;
  final String? fileName;
  final String? extensionFile;
  final double? size;

  @override
  List<Object?> get props => [id, url, fileName, extensionFile, size];

  @override
  bool get stringify => true;
}
