import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class AttendanceImageEntity extends Equatable {
  const AttendanceImageEntity({
    required this.id,
    required this.url,
    this.fileName,
    this.extensionFile,
    this.size,
    this.workingFrom,
  });

  final int id;
  final String url;
  final String? fileName;
  final String? extensionFile;
  final double? size;
  final WorkingFromType? workingFrom;

  @override
  List<Object?> get props =>
      [id, url, fileName, extensionFile, size, workingFrom];

  @override
  bool get stringify => true;
}
