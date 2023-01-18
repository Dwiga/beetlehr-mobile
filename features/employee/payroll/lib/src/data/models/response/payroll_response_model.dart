import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

class PayrollResponseModel extends Equatable {
  const PayrollResponseModel({
    required this.data,
    this.meta,
  });

  final List<PayrollModel> data;
  final MetaData? meta;

  factory PayrollResponseModel.fromJson(Map<String, dynamic> json) {
    return PayrollResponseModel(
      data: json["data"] != null
          ? List<PayrollModel>.from(
              json["data"].map((x) => PayrollModel.fromJson(x)))
          : [],
      meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
    );
  }

  @override
  List<Object?> get props => [data, meta];
}
