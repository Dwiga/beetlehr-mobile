import 'package:dependencies/dependencies.dart';

class ApproverResponseEntity extends Equatable {
  final String approver;
  final String type;
  final String status;

  const ApproverResponseEntity({
    required this.approver,
    required this.type,
    required this.status,
  });

  @override
  List<Object?> get props => [approver, type, status];

  @override
  bool get stringify => true;
}
