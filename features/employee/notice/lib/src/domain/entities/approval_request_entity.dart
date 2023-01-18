import 'package:dependencies/dependencies.dart';
import 'package:notice/notice.dart';

class ApprovalRequestEntity extends Equatable {
  final int id;
  final String requestName;
  final String? requestImage;
  final String type;
  final String typeLabel;
  final String requestedAt;
  final String status;
  final String statusLabel;
  final MetaDataApprovalModel? metaData;

  const ApprovalRequestEntity({
    required this.id,
    required this.requestName,
    this.requestImage,
    required this.type,
    required this.typeLabel,
    required this.requestedAt,
    required this.status,
    required this.statusLabel,
    required this.metaData,
  });

  @override
  List<Object?> get props => [
        id,
        requestName,
        requestImage,
        type,
        typeLabel,
        requestedAt,
        status,
        statusLabel,
        metaData
      ];

  @override
  bool get stringify => true;
}
