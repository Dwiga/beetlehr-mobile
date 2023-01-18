import 'dart:io';

import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class UploadAttendanceImageBodyModel extends Equatable {
  final File image;
  final AttendanceClockType type;
  final DateTime date;
  final WorkingFromType workingFrom;

  const UploadAttendanceImageBodyModel({
    required this.image,
    required this.type,
    required this.date,
    required this.workingFrom,
  });

  Future<FormData> toJson() async {
    return FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
      'type': type.convertToString(),
      'date': DateFormat('y-MM-dd').format(date),
      'status': workingFrom.convertToString(),
    });
  }

  @override
  List<Object> get props => [image, type, date, workingFrom];

  @override
  bool get stringify => true;
}
