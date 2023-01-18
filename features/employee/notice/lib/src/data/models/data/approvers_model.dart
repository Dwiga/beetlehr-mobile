import 'package:dependencies/dependencies.dart';

class ApproversModel extends Equatable {
  final int userId;
  final String approverName;
  final String? approverImage;
  final String designation;
  final String status;
  final String statusLabel;
  final String? reason;
  final String? timestamp;
  final String? timestampGmt;

  const ApproversModel({
    required this.userId,
    required this.approverName,
    this.approverImage,
    required this.designation,
    required this.status,
    required this.statusLabel,
    required this.reason,
    required this.timestamp,
    required this.timestampGmt,
  });

  factory ApproversModel.fromJson(Map<String, dynamic> json) {
    return ApproversModel(
        userId: json['user_id'],
        approverName: json['approver_name'],
        approverImage: json['approver_image'] ?? '',
        designation: json['designation'],
        status: json['status'],
        statusLabel: json['status_label'],
        reason: json['reason'] ?? '',
        timestamp: json['timestamp'] ?? '',
        timestampGmt: json['timestamp_gmt'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'approver_name': approverName,
      'approver_image': approverImage,
      'designation': designation,
      'status': status,
      'status_label': statusLabel,
      'reason': reason,
      'timestamp': timestamp,
      'timestamp_gmt': timestampGmt
    };
  }

  @override
  List<Object?> get props => [
        userId,
        approverName,
        approverImage,
        designation,
        status,
        statusLabel,
        reason,
        timestamp,
        timestampGmt
      ];
}
