import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class AttendanceImageResponseModel extends Equatable {
  final AttendanceImageModel data;
  final MetaData? meta;
  const AttendanceImageResponseModel({
    required this.data,
    this.meta,
  });

  factory AttendanceImageResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceImageResponseModel(
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
      data: AttendanceImageModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'meta': meta?.toJson(),
    };
  }

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
