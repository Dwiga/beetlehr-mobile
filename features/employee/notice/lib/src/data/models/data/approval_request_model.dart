import '../../../../notice.dart';

class ApprovalRequestModel extends ApprovalRequestEntity {
  const ApprovalRequestModel({
    required int id,
    required String requestName,
    required String? requestImage,
    required String type,
    required String typeLabel,
    required String requestAt,
    required String status,
    required String statusLabel,
    MetaDataApprovalModel? metaData,
  }) : super(
          id: id,
          requestName: requestName,
          requestImage: requestImage,
          type: type,
          typeLabel: typeLabel,
          requestedAt: requestAt,
          status: status,
          statusLabel: statusLabel,
          metaData: metaData,
        );

  factory ApprovalRequestModel.fromJson(Map<String, dynamic> json) {
    return ApprovalRequestModel(
        id: json['id'],
        requestName: json['requester_name'],
        requestImage: json['requester_image'],
        type: json['type'],
        typeLabel: json['type_label'],
        requestAt: json['requested_at'],
        status: json['status'],
        statusLabel: json['status_label'],
        metaData: json['meta_data'] != null
            ? MetaDataApprovalModel.fromJson(json['meta_data'])
            : null);
  }
}

extension ApprovalRequestModelX on ApprovalRequestEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_name': requestName,
      'request_image': requestImage,
      'type': type,
      'type_label': typeLabel,
      'requested_at': requestedAt,
      'status': status,
      'status_label': statusLabel,
      'meta_data': metaData,
    };
  }
}
