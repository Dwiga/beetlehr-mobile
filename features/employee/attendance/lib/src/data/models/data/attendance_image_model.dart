import 'package:core/core.dart';

import '../../../../attendance.dart';

class AttendanceImageModel extends AttendanceImageEntity {
  const AttendanceImageModel({
    required int id,
    required String url,
    String? fileName,
    String? extensionFile,
    double? size,
    WorkingFromType? workingFrom,
  }) : super(
          id: id,
          url: url,
          fileName: fileName,
          extensionFile: extensionFile,
          size: size,
          workingFrom: workingFrom,
        );

  factory AttendanceImageModel.fromJson(Map<String, dynamic> json) =>
      AttendanceImageModel(
        id: json["id"],
        url: json["url"],
        fileName: json["file_name"],
        extensionFile: json["extension"],
        size: Utils.doubleParser(json['size']),
        workingFrom: workingFromTypefromString(json['status']),
      );
}

extension AttendanceImageModelX on AttendanceImageEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "file_name": fileName,
        "extension": extensionFile,
        'size': size,
        'status': workingFrom?.convertToString(),
      };
}
