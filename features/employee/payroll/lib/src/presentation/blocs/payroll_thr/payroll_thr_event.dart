part of 'payroll_thr_bloc.dart';

abstract class PayrollTHREvent extends Equatable {
  const PayrollTHREvent();
}

class FetchPayrollTHREvent extends PayrollTHREvent {
  final int page;
  final int perPage;

  const FetchPayrollTHREvent({required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
