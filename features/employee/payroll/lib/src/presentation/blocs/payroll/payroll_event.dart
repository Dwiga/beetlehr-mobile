part of 'payroll_bloc.dart';

abstract class PayrollEvent extends Equatable {
  const PayrollEvent();
}

class FetchPayrollEvent extends PayrollEvent {
  final int? year;
  final int? month;
  final int page;
  final int perPage;

  const FetchPayrollEvent(
      {required this.year,
      required this.month,
      required this.page,
      required this.perPage});

  @override
  List<Object?> get props => [year, month, page, perPage];
}
