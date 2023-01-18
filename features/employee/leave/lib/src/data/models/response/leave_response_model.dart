import 'package:core/core.dart';

import '../../data.dart';

class LeaveResponseModel {
  LeaveResponseModel({
    required this.data,
    required this.quota,
    this.meta,
  });

  final List<LeaveModel> data;
  final int quota;
  final MetaData? meta;

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveResponseModel(
      data: List<LeaveModel>.from(
          json["data"].map((x) => LeaveModel.fromJson(x))),
      quota: Utils.intParser(json["quota"]) ?? 0,
      meta: MetaData.fromJson(json["meta"]),
    );
  }
}
