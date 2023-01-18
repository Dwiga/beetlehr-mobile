import 'package:dependencies/dependencies.dart';
import 'package:notice/notice.dart';

class ApprovalRequestFilterEntity extends Equatable {
  final String? sortBy;
  final String? requestType;
  final String? startTime;
  final String? endTime;
  final List<EmployeeNameFilterEntity>? employees;
  final int? totalItemFilter;

  const ApprovalRequestFilterEntity(
      {this.sortBy,
      this.requestType,
      this.startTime,
      this.endTime,
      this.employees,
      this.totalItemFilter});

  @override
  List<Object?> get props =>
      [sortBy, requestType, startTime, endTime, employees, totalItemFilter];

  @override
  bool get stringify => true;
}
