import 'package:core/core.dart';

import '../../data.dart';

class LeaveTypeResponseModel {
  LeaveTypeResponseModel({
    required this.data,
    this.meta,
  });

  final List<LeaveTypeModel> data;
  final MetaData? meta;

  factory LeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeResponseModel(
      data: List<LeaveTypeModel>.from(
          json["data"].map((x) => LeaveTypeModel.fromJson(x))),
      meta: MetaData.fromJson(json["meta"]),
    );
  }
}
