import 'package:core/core.dart';

import '../../../../payroll.dart';

class PayrollDetailResponse {
  PayrollDetailResponse({
    required this.data,
    this.meta,
  });

  final PayrollDetailModel data;
  final MetaData? meta;

  factory PayrollDetailResponse.fromJson(Map<String, dynamic> json) {
    return PayrollDetailResponse(
      data: PayrollDetailModel.fromJson(json["data"]),
      meta: MetaData.fromJson(json["meta"]),
    );
  }
}
