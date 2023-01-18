import 'package:dependencies/dependencies.dart';

import '../../../payroll.dart';

class PayrollEntity extends Equatable {
  const PayrollEntity({
    required this.id,
    required this.name,
    this.date,
    required this.status,
    required this.totalAmount,
  });

  final int id;
  final String name;
  final DateTime? date;
  final PayrollStatus status;
  final double totalAmount;

  @override
  List<Object?> get props => [id, name, date, status, totalAmount];

  @override
  bool get stringify => true;
}
