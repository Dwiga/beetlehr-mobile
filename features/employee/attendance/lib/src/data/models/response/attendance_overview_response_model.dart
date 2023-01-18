import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class AttendanceOverviewResponseModel extends Equatable {
  final AttendanceOverviewModel data;
  final MetaData? meta;

  const AttendanceOverviewResponseModel({
    required this.data,
    this.meta,
  });

  factory AttendanceOverviewResponseModel.fromJson(Map<String, dynamic> json) =>
      AttendanceOverviewResponseModel(
        data: AttendanceOverviewModel.fromJson(json["data"]),
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
