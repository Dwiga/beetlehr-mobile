import 'package:core/core.dart';

import '../../../../notice.dart';

class ApproverRequestResponseModel {
  final ApproverResponseModel data;
  final MetaData? meta;

  ApproverRequestResponseModel({
    required this.data,
    this.meta,
  });

  factory ApproverRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return ApproverRequestResponseModel(
      data: ApproverResponseModel.fromJson(json['data']),
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }
}
