part of 'payroll_thr_detail_bloc.dart';

abstract class PayrollTHRDetailState extends Equatable {}

class PayrollTHRDetailLoading extends PayrollTHRDetailState {
  @override
  List<Object> get props => [];
}

class PayrollTHRDetailSuccess extends PayrollTHRDetailState {
  final PayrollDetailEntity data;

  PayrollTHRDetailSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class PayrollTHRDetailFailure extends PayrollTHRDetailState {
  final Failure failure;

  PayrollTHRDetailFailure(this.failure);
  @override
  List<Object> get props => [failure];
}
