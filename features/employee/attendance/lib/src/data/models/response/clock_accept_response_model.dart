import 'package:core/core.dart';

import '../../../../attendance.dart';

class ClockAcceptResponseModel {
  ClockAcceptResponseModel({
    required this.data,
    this.meta,
  });

  final ClockAcceptModel data;
  final MetaData? meta;

  factory ClockAcceptResponseModel.fromJson(Map<String, dynamic> json) =>
      ClockAcceptResponseModel(
        data: ClockAcceptModel.fromJson(json["data"]),
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta?.toJson(),
      };
}
