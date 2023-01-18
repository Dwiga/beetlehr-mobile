enum ApprovalRequestType {
  awaiting,
  rejected,
  approved,
}

ApprovalRequestType? approvalRequestTypefromString(String? type) {
  switch (type) {
    case 'awaiting':
      return ApprovalRequestType.awaiting;
    case 'rejected':
      return ApprovalRequestType.rejected;
    case 'approved':
      return ApprovalRequestType.approved;
    default:
      return null;
  }
}

extension ApprovalRequestTypeX on ApprovalRequestType {
  String convertToString() {
    switch (this) {
      case ApprovalRequestType.awaiting:
        return 'awaiting';
      case ApprovalRequestType.rejected:
        return 'rejected';
      case ApprovalRequestType.approved:
        return 'approved';
    }
  }
}
