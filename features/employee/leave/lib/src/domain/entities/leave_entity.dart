import 'package:dependencies/dependencies.dart';

import '../domain.dart';

class LeaveEntity extends Equatable {
  const LeaveEntity({
    required this.id,
    required this.leaveType,
    required this.status,
    required this.startDate,
    this.label,
    required this.totalDate,
  });

  final int id;
  final String leaveType;
  final LeaveStatus status;
  final String startDate;
  final String? label;
  final int totalDate;

  @override
  List<Object?> get props => [
        id,
        leaveType,
        status,
        startDate,
        label,
        totalDate,
      ];

  @override
  bool get stringify => true;
}
