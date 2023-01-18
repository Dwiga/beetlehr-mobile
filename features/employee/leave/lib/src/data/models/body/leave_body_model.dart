import 'dart:io';

import 'package:dependencies/dependencies.dart';

class LeaveBodyModel extends Equatable {
  const LeaveBodyModel({
    required this.leaveTypeId,
    this.startDate,
    this.endDate,
    required this.reason,
    this.file,
  });

  final int leaveTypeId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String reason;
  final File? file;

  Map<String, dynamic> toJson() => {
        "leave_type_id": leaveTypeId,
        "start_date":
            startDate != null ? DateFormat('y-MM-dd').format(startDate!) : null,
        "end_date":
            endDate != null ? DateFormat('y-MM-dd').format(endDate!) : null,
        "reason": reason,
        "file": file,
      };

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "leave_type_id": leaveTypeId,
      "start_date":
          startDate != null ? DateFormat('y-MM-dd').format(startDate!) : null,
      "end_date":
          endDate != null ? DateFormat('y-MM-dd').format(endDate!) : null,
      "reason": reason,
      "file": file != null ? await MultipartFile.fromFile(file!.path) : null,
    });
  }

  @override
  List<Object?> get props => [leaveTypeId, startDate, endDate, reason, file];
}
