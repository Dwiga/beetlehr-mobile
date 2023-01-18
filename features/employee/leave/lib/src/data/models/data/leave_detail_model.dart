import 'package:core/core.dart';

import '../../../../leave.dart';

class LeaveDetailModel extends LeaveDetailEntity {
  const LeaveDetailModel({
    required int id,
    required String leaveType,
    required LeaveStatus status,
    required String startDate,
    int? totalDate,
    required String label,
    String? reason,
    String? rejectReason,
    String? fileUrl,
  }) : super(
          id: id,
          leaveType: leaveType,
          status: status,
          startDate: startDate,
          totalDate: totalDate,
          label: label,
          reason: reason,
          rejectReason: rejectReason,
          fileUrl: fileUrl,
        );

  factory LeaveDetailModel.fromJson(Map<String, dynamic> json) {
    return LeaveDetailModel(
      id: Utils.intParser(json["id"]) ?? 0,
      leaveType: json["leave_type"],
      status: LeaveStatusConverter.fromString(json["status"]) ??
          LeaveStatus.waiting,
      startDate: json["start_date"],
      totalDate: Utils.intParser(json['total_date']),
      label: json["label"],
      reason: json["reason"],
      rejectReason: json["reject_reason"],
      fileUrl: json["file_url"],
    );
  }
}

extension LeaveDetailEntityX on LeaveDetailEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "status": status.convertToString(),
        "start_date": startDate,
        "total_date": totalDate,
        "label": label,
        "reason": reason,
        "reject_reason": rejectReason,
        "file_url": fileUrl,
      };
}
