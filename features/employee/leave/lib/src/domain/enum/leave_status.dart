import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:preferences/preferences.dart';

enum LeaveStatus { approved, waiting, rejected, cancelled }

extension LeaveStatusX on LeaveStatus {
  String convertToString() {
    return describeEnum(this);
  }

  Color? getColor() {
    switch (this) {
      case LeaveStatus.approved:
        return StaticColors.green;
      case LeaveStatus.waiting:
        return StaticColors.yellow;
      case LeaveStatus.cancelled:
      case LeaveStatus.rejected:
        return StaticColors.red;
      default:
        return null;
    }
  }
}

class LeaveStatusConverter {
  const LeaveStatusConverter._();

  static LeaveStatus? fromString(String? v) {
    switch (v) {
      case 'approved':
        return LeaveStatus.approved;
      case 'waiting':
        return LeaveStatus.waiting;
      case 'rejected':
        return LeaveStatus.rejected;
      case 'cancelled':
        return LeaveStatus.cancelled;
      default:
        return null;
    }
  }
}
