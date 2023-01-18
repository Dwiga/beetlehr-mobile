import 'package:core/core.dart';

import '../../../domain/domain.dart';

class NetworkFileModel extends NetworkFileEntity {
  NetworkFileModel({
    required int id,
    required String url,
    String? fileName,
    String? extensionFile,
    double? size,
  }) : super(
          id: id,
          url: url,
          fileName: fileName,
          extensionFile: extensionFile,
          size: size,
        );

  factory NetworkFileModel.fromJson(Map<String, dynamic> json) =>
      NetworkFileModel(
        id: json["id"],
        url: json["url"],
        fileName: json["file_name"],
        extensionFile: json["extension"],
        size: Utils.doubleParser(json['size']),
      );
}

extension NetworkFileModelX on NetworkFileEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "file_name": fileName,
        "extension": extensionFile,
        'size': size,
      };
}
