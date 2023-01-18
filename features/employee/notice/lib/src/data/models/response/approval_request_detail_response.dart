import 'package:core/core.dart';

import '../../../../notice.dart';

class ApprovalRequestDetailResponseModel {
  final ApprovalRequestDetailDataModel data;
  final MetaData? meta;

  ApprovalRequestDetailResponseModel({
    required this.data,
    this.meta,
  });

  factory ApprovalRequestDetailResponseModel.fromJson(
      Map<String, dynamic> json) {
    return ApprovalRequestDetailResponseModel(
      data: ApprovalRequestDetailDataModel.fromJson(json['data']),
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }
}
