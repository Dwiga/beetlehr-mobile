import 'package:core/core.dart';

import '../../../domain/domain.dart';

class LeaveModel extends LeaveEntity {
  const LeaveModel({
    required int id,
    required String leaveType,
    required LeaveStatus status,
    required String startDate,
    String? label,
    required int totalDate,
  }) : super(
          id: id,
          leaveType: leaveType,
          status: status,
          startDate: startDate,
          label: label,
          totalDate: totalDate,
        );

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: Utils.intParser(json["id"]) ?? 0,
      leaveType: json["leave_type"],
      status: LeaveStatusConverter.fromString(json["status"]) ??
          LeaveStatus.waiting,
      startDate: json["start_date"],
      label: json["label"],
      totalDate: Utils.intParser(json['total_date']) ?? 0,
    );
  }
}

extension LeaveEntityX on LeaveEntity {
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "leave_type": leaveType,
      "status": status.convertToString(),
      "start_date": startDate,
      "label": label,
      "total_date": totalDate,
    };
  }
}
