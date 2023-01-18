import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

class ApprovalRequestResponseModel extends Equatable {
  final List<ApprovalRequestModel> data;
  final MetaData? meta;
  const ApprovalRequestResponseModel({
    required this.data,
    this.meta,
  });

  factory ApprovalRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return ApprovalRequestResponseModel(
      data: json['data'] != null
          ? List<ApprovalRequestModel>.from(
              json["data"].map((x) => ApprovalRequestModel.fromJson(x)))
          : [],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
