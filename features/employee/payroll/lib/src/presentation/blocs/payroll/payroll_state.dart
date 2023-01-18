part of 'payroll_bloc.dart';

abstract class PayrollState extends Equatable {
  const PayrollState();
}

class PayrollInitial extends PayrollState {
  @override
  List<Object> get props => [];
}

class PayrollSuccess extends PayrollState {
  final List<PayrollEntity> data;
  final bool hasReachedMax;
  final int page;
  const PayrollSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];

  @override
  bool get stringify => true;
}

class PayrollFailure extends PayrollState {
  final Failure failure;

  const PayrollFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
