enum ResignStatus { waiting, approved, rejected }

class ResignStatusConverter {
  static ResignStatus? fromString(String? v) {
    switch (v) {
      case 'waiting':
        return ResignStatus.waiting;
      case 'approved':
        return ResignStatus.approved;
      case 'rejected':
        return ResignStatus.rejected;
      default:
        return null;
    }
  }

  static String? convertToString(ResignStatus? v) {
    switch (v) {
      case ResignStatus.waiting:
        return 'waiting';
      case ResignStatus.approved:
        return 'approved';
      case ResignStatus.rejected:
        return 'rejected';
      default:
        return null;
    }
  }
}
