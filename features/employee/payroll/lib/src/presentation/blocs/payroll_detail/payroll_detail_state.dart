part of 'payroll_detail_bloc.dart';

abstract class PayrollDetailState extends Equatable {}

class PayrollDetailLoading extends PayrollDetailState {
  @override
  List<Object> get props => [];
}

class PayrollDetailSuccess extends PayrollDetailState {
  final PayrollDetailEntity data;

  PayrollDetailSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class PayrollDetailFailure extends PayrollDetailState {
  final Failure failure;

  PayrollDetailFailure(this.failure);
  @override
  List<Object> get props => [failure];
}
