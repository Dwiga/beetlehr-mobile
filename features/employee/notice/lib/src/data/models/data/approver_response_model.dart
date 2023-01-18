import 'package:notice/src/domain/entities/approver_response_entity.dart';

class ApproverResponseModel extends ApproverResponseEntity {
  const ApproverResponseModel({
    required String approver,
    required String type,
    required String status,
  }) : super(approver: approver, type: type, status: status);

  factory ApproverResponseModel.fromJson(Map<String, dynamic> json) {
    return ApproverResponseModel(
        approver: json['approver'] ?? '',
        type: json['type'],
        status: json['status']);
  }
}

extension ApproveRequestModelX on ApproverResponseEntity {
  Map<String, dynamic> toJson() {
    return {
      'approver': approver,
      'type': type,
      'status': status,
    };
  }
}
