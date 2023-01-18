part of 'employee_name_filter_bloc.dart';

abstract class EmployeeNameFilterState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmployeeNameFilterLoading extends EmployeeNameFilterState {}

class EmployeeNameFilterFailure extends EmployeeNameFilterState {
  final Failure failure;
  EmployeeNameFilterFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class EmployeeNameFilterSuccess extends EmployeeNameFilterState {
  final List<EmployeeNameFilterEntity> data;
  final bool hasReachedMax;
  final int page;

  EmployeeNameFilterSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];
}
