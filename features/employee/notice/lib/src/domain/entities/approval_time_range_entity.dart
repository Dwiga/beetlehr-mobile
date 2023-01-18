import 'package:dependencies/dependencies.dart';

class ApprovalTimeRangeEntity extends Equatable {
  final String? startTime;
  final String? endTime;

  const ApprovalTimeRangeEntity({
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [startTime, endTime];

  @override
  bool get stringify => true;
}
