import 'package:core/core.dart';

import '../../../../leave.dart';

class LeaveDetailResponseModel {
  LeaveDetailResponseModel({
    required this.data,
    this.meta,
  });

  final LeaveDetailModel data;
  final MetaData? meta;

  factory LeaveDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveDetailResponseModel(
      data: LeaveDetailModel.fromJson(json["data"]),
      meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
    );
  }
}
