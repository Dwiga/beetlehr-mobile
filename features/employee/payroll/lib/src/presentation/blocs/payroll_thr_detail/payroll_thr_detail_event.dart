part of 'payroll_thr_detail_bloc.dart';

abstract class PayrollTHRDetailEvent extends Equatable {}

class FetchPayrollTHRDetailEvent extends PayrollTHRDetailEvent {
  final int id;
  FetchPayrollTHRDetailEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
