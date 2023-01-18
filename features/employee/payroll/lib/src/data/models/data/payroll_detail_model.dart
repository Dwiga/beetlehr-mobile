import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

class PayrollDetailModel extends PayrollDetailEntity {
  const PayrollDetailModel({
    required String name,
    String? image,
    required String designation,
    required PayrollStatus status,
    DateTime? paidOn,
    required double totalEarning,
    required double totalDeduction,
    required double totalAmount,
    double? totalAmountAfterPinalty,
    double? resignPinaltyAmount,
    required List<PayrollComponentEntity> earnings,
    List<PayrollComponentEntity>? deductions,
    required String publicUrl,
  }) : super(
          name: name,
          image: image,
          designation: designation,
          status: status,
          paidOn: paidOn,
          totalEarning: totalEarning,
          totalDeduction: totalDeduction,
          totalAmount: totalAmount,
          resignPinaltyAmount: resignPinaltyAmount,
          totalAmountAfterPinalty: totalAmountAfterPinalty,
          earnings: earnings,
          deductions: deductions,
          publicUrl: publicUrl,
        );

  factory PayrollDetailModel.fromJson(Map<String, dynamic> json) {
    return PayrollDetailModel(
      name: json["name"] ?? '',
      image: json["image"] ?? '',
      designation: json["designation"] ?? '',
      status: PayrollStatusConverter.fromString(json["status"]) ??
          PayrollStatus.generated,
      paidOn: json["paid_on"] != null
          ? DateTime.parse(json["paid_on"]).toLocal()
          : null,
      totalEarning: Utils.doubleParser(json["total_earning"]) ?? 0,
      totalDeduction: Utils.doubleParser(json["total_deduction"]) ?? 0,
      totalAmount: Utils.doubleParser(json["total_amount"]) ?? 0,
      resignPinaltyAmount:
          Utils.doubleParser(json['resign_pinalty_amount']) ?? 0,
      totalAmountAfterPinalty:
          Utils.doubleParser(json['total_amount_after_pinalty']),
      earnings: json["earnings"] != null
          ? List<PayrollComponentModel>.from(
              json["earnings"].map((x) => PayrollComponentModel.fromJson(x)))
          : [],
      deductions: json["deductions"] != null
          ? List<PayrollComponentModel>.from(
              json["deductions"].map((x) => PayrollComponentModel.fromJson(x)))
          : [],
      publicUrl: json['public_url'] ?? '',
    );
  }
}

extension PayrollDetailModelX on PayrollDetailEntity {
  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "designation": designation,
        "status": PayrollStatusConverter.convertToString(status),
        "paid_on":
            paidOn != null ? DateFormat('y-MM-dd').format(paidOn!) : null,
        "total_earning": totalEarning,
        "total_deduction": totalDeduction,
        "total_amount": totalAmount,
        'resign_pinalty_amount': resignPinaltyAmount,
        'total_amount_after_pinalty': totalAmountAfterPinalty,
        "earnings": List<dynamic>.from(earnings.map((x) => x.toJson())),
        "deductions": deductions != null
            ? List<dynamic>.from(deductions!.map((x) => x.toJson()))
            : [],
        'public_url': publicUrl,
      };
}
