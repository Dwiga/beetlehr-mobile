import 'package:dependencies/dependencies.dart';

import '../../../payroll.dart';

class PayrollDetailEntity extends Equatable {
  const PayrollDetailEntity({
    required this.name,
    this.image,
    required this.designation,
    required this.status,
    this.paidOn,
    required this.totalEarning,
    required this.totalDeduction,
    required this.totalAmount,
    this.totalAmountAfterPinalty,
    this.resignPinaltyAmount,
    required this.earnings,
    required this.deductions,
    required this.publicUrl,
  });

  final String name;
  final String? image;
  final String designation;
  final PayrollStatus status;
  final DateTime? paidOn;
  final double totalEarning;
  final double totalDeduction;
  final double totalAmount;
  final double? totalAmountAfterPinalty;
  final double? resignPinaltyAmount;
  final List<PayrollComponentEntity> earnings;
  final List<PayrollComponentEntity>? deductions;
  final String publicUrl;

  @override
  List<Object?> get props => [
        name,
        image,
        designation,
        status,
        paidOn,
        totalEarning,
        totalDeduction,
        totalAmount,
        resignPinaltyAmount,
        totalAmountAfterPinalty,
        earnings,
        deductions,
        publicUrl,
      ];
}
