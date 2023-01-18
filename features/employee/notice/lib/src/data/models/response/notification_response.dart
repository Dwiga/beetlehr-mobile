import 'package:core/core.dart';

import '../../../../notice.dart';

class NotificationResponseModel {
  final List<NotificationModel> data;
  final MetaData? meta;

  NotificationResponseModel({
    required this.data,
    this.meta,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      data: json['data'] != null
          ? List<NotificationModel>.from(
              json["data"].map((x) => NotificationModel.fromJson(x)))
          : [],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }
}
