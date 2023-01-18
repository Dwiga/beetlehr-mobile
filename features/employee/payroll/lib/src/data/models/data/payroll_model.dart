import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

class PayrollModel extends PayrollEntity {
  const PayrollModel({
    required int id,
    required String name,
    DateTime? date,
    required PayrollStatus status,
    required double totalAmount,
  }) : super(
          id: id,
          name: name,
          date: date,
          status: status,
          totalAmount: totalAmount,
        );

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      id: json["id"],
      name: json["name"],
      date:
          json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
      status: PayrollStatusConverter.fromString(json["status"]) ??
          PayrollStatus.generated,
      totalAmount: Utils.doubleParser(json["total_amount"]) ?? 0,
    );
  }

  PayrollEntity toEntity() {
    return PayrollEntity(
      id: id,
      date: date,
      name: name,
      status: status,
      totalAmount: totalAmount,
    );
  }
}

extension PayrollModelX on PayrollEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date != null ? DateFormat('y-MM-dd').format(date!) : null,
        "status": PayrollStatusConverter.convertToString(status),
        "total_amount": totalAmount,
      };
}
