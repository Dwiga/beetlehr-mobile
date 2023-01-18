import 'package:dependencies/dependencies.dart';

class PayrollComponentEntity extends Equatable {
  final String name;
  final double amount;

  const PayrollComponentEntity({required this.name, required this.amount});

  @override
  List<Object> get props => [name, amount];

  @override
  bool get stringify => true;
}
