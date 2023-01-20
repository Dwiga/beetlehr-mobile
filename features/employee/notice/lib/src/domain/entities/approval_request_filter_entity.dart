import 'package:dependencies/dependencies.dart';

class ApprovalRequestFilterEntity extends Equatable {
  final String? sortBy;
  final String? startTime;
  final String? endTime;
  final int? totalItemFilter;

  const ApprovalRequestFilterEntity({
    this.sortBy,
    this.startTime,
    this.endTime,
    this.totalItemFilter,
  });

  @override
  List<Object?> get props => [sortBy, startTime, endTime, totalItemFilter];

  @override
  bool get stringify => true;
}
