import 'package:dependencies/dependencies.dart';
import 'package:notice/notice.dart';

class ApprovalRequestDetailEntity extends Equatable {
  final int id;
  final String requesterName;
  final String? requesterImage;
  final String requesterDesignation;
  final String requesterPlacment;
  final String type;
  final bool isApprovable;
  final ApprovalRequestType status;
  final String statusLabel;
  final MetaDataApprovalModel metaData;
  final List<ApproversModel> approvers;

  const ApprovalRequestDetailEntity(
      {required this.id,
      required this.requesterName,
      required this.requesterImage,
      required this.requesterDesignation,
      required this.requesterPlacment,
      required this.type,
      required this.isApprovable,
      required this.status,
      required this.statusLabel,
      required this.metaData,
      required this.approvers});

  @override
  List<Object?> get props => [
        id,
        requesterName,
        requesterImage,
        requesterDesignation,
        requesterDesignation,
        requesterPlacment,
        type,
        isApprovable,
        status,
        statusLabel,
        metaData,
        approvers
      ];

  @override
  bool get stringify => true;
}
