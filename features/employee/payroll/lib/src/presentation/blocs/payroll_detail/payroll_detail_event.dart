part of 'payroll_detail_bloc.dart';

abstract class PayrollDetailEvent extends Equatable {}

class FetchPayrollDetailEvent extends PayrollDetailEvent {
  final int id;
  FetchPayrollDetailEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
