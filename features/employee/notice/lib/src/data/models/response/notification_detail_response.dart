import 'package:core/core.dart';

import '../../../../notice.dart';

class NotificationDetailResponseModel {
  final NotificationDetailModel data;
  final MetaData? meta;

  NotificationDetailResponseModel({
    required this.data,
    this.meta,
  });

  factory NotificationDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationDetailResponseModel(
      data: NotificationDetailModel.fromJson(json['data']),
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }
}
