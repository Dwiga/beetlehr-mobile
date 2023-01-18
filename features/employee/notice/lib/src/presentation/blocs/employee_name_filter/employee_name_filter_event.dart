part of 'employee_name_filter_bloc.dart';

abstract class EmployeeNameFilterEvent extends Equatable {
  const EmployeeNameFilterEvent();
}

class FetchEmployeeNameFilterEvent extends EmployeeNameFilterEvent {
  final int perPage;
  final int page;
  final String name;

  const FetchEmployeeNameFilterEvent(
      {required this.perPage, required this.page, required this.name});

  @override
  List<Object> get props => [perPage, page, name];
}
