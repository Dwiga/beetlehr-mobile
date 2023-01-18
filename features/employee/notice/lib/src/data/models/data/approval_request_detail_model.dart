import '../../../../notice.dart';

class ApprovalRequestDetailDataModel extends ApprovalRequestDetailEntity {
  const ApprovalRequestDetailDataModel(
      {required int id,
      required String requesterName,
      required String? requesterImage,
      required String requesterDesignation,
      required String requesterPlacment,
      required String type,
      required bool isApprovable,
      required ApprovalRequestType status,
      required String statusLabel,
      required MetaDataApprovalModel metaData,
      required List<ApproversModel> approvers})
      : super(
            id: id,
            requesterName: requesterName,
            requesterImage: requesterImage,
            requesterDesignation: requesterDesignation,
            requesterPlacment: requesterPlacment,
            type: type,
            isApprovable: isApprovable,
            status: status,
            statusLabel: statusLabel,
            metaData: metaData,
            approvers: approvers);

  factory ApprovalRequestDetailDataModel.fromJson(Map<String, dynamic> json) {
    return ApprovalRequestDetailDataModel(
      id: json['id'],
      requesterName: json['requester_name'],
      requesterImage: json['requester_image'] ?? '',
      requesterDesignation: json['requester_designation'],
      requesterPlacment: json['requester_placement'],
      type: json['type'],
      isApprovable: json['is_approvable'],
      status: approvalRequestTypefromString(json['status']) ??
          ApprovalRequestType.awaiting,
      statusLabel: json['status_label'],
      metaData: MetaDataApprovalModel.fromJson(json['meta_data']),
      approvers: json["approvers"] != null
          ? List<ApproversModel>.from(
              json["approvers"].map((x) => ApproversModel.fromJson(x)))
          : [],
    );
  }
}

extension ApprovalRequestDetailDataModelX on ApprovalRequestDetailEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requester_name': requesterName,
      'requester_image': requesterImage,
      'requester_designation': requesterDesignation,
      'requester_placment': requesterPlacment,
      'type': type,
      'is_approvable': isApprovable,
      'status': approvalRequestTypefromString(status.toString()),
      'status_label': statusLabel,
      'meta_data': metaData.toJson(),
      'approvers': List<dynamic>.from(approvers.map((x) => x.toJson())),
    };
  }
}
