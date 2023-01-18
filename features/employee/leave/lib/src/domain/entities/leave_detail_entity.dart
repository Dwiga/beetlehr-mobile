import 'package:dependencies/dependencies.dart';

import '../../../leave.dart';

class LeaveDetailEntity extends Equatable {
  const LeaveDetailEntity({
    required this.id,
    required this.leaveType,
    required this.status,
    required this.startDate,
    this.totalDate,
    required this.label,
    this.reason,
    this.rejectReason,
    this.fileUrl,
  });

  final int id;
  final String leaveType;
  final LeaveStatus status;
  final String startDate;
  final int? totalDate;
  final String label;
  final String? reason;
  final String? rejectReason;
  final String? fileUrl;

  @override
  List<Object?> get props => [
        id,
        leaveType,
        status,
        startDate,
        totalDate,
        label,
        reason,
        rejectReason,
        fileUrl,
      ];

  @override
  bool get stringify => true;
}
