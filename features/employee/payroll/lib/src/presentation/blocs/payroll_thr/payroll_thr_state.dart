part of 'payroll_thr_bloc.dart';

abstract class PayrollTHRState extends Equatable {
  const PayrollTHRState();
}

class PayrollTHRInitial extends PayrollTHRState {
  @override
  List<Object> get props => [];
}

class PayrollTHRSuccess extends PayrollTHRState {
  final List<PayrollEntity> data;
  final bool hasReachedMax;
  final int page;
  const PayrollTHRSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];

  @override
  bool get stringify => true;
}

class PayrollTHRFailure extends PayrollTHRState {
  final Failure failure;

  const PayrollTHRFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
