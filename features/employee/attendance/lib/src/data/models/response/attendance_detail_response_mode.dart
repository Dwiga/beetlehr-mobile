import 'package:core/core.dart';

import '../../../../attendance.dart';

class AttendanceDetailResponseModel {
  AttendanceDetailResponseModel({
    required this.data,
    this.totalHours,
    this.meta,
  });

  final List<AttendanceDetailModel> data;
  final String? totalHours;
  final MetaData? meta;

  factory AttendanceDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailResponseModel(
        data: json["data"] != null
            ? List<AttendanceDetailModel>.from(
                json["data"].map((x) => AttendanceDetailModel.fromJson(x)))
            : [],
        totalHours: json["total_hours"],
        meta: MetaData.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total_hours": totalHours,
        "meta": meta?.toJson(),
      };
}
