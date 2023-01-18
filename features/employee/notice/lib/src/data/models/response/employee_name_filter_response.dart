import 'package:core/core.dart';

import '../../../../notice.dart';

class EmployeeNameFilterResponseModel {
  final List<EmployeeNameFilterModel> data;
  final MetaData? meta;

  EmployeeNameFilterResponseModel({
    required this.data,
    this.meta,
  });

  factory EmployeeNameFilterResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeNameFilterResponseModel(
      data: json['data'] != null
          ? List<EmployeeNameFilterModel>.from(
              json["data"].map((x) => EmployeeNameFilterModel.fromJson(x)))
          : [],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }
}
