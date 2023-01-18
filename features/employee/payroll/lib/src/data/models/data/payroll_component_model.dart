import 'package:core/core.dart';

import '../../../../payroll.dart';

class PayrollComponentModel extends PayrollComponentEntity {
  const PayrollComponentModel({
    required String name,
    required double amount,
  }) : super(name: name, amount: amount);

  factory PayrollComponentModel.fromJson(Map<String, dynamic> json) {
    return PayrollComponentModel(
      name: json["name"],
      amount: Utils.doubleParser(json["amount"]) ?? 0,
    );
  }
}

extension PayrollComponentModelX on PayrollComponentEntity {
  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}
