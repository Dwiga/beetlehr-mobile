import 'package:attendance/src/data/models/data/break_time_model.dart';
import 'package:core/core.dart';

class BreakTimeResponseModel {
  BreakTimeResponseModel({
    required this.data,
    this.meta,
  });

  final BreakTimeModel data;
  final MetaData? meta;

  factory BreakTimeResponseModel.fromJson(Map<String, dynamic> json) =>
      BreakTimeResponseModel(
        data: BreakTimeModel.fromJson(json["data"]),
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta?.toJson(),
      };
}
