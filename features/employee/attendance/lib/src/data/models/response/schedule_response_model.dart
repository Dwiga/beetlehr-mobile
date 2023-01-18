import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class ScheduleResponseModel extends Equatable {
  final List<ScheduleModel> data;
  final MetaData? meta;

  const ScheduleResponseModel({required this.data, this.meta});

  factory ScheduleResponseModel.fromJson(Map<String, dynamic> json) =>
      ScheduleResponseModel(
        data: json['data'] != null
            ? List<ScheduleModel>.from(
                json["data"].map((x) => ScheduleModel.fromJson(x)))
            : [],
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
