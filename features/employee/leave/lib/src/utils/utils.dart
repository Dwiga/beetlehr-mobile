import 'package:component/component.dart';
import 'package:flutter/material.dart';

import '../../leave.dart';

class LeaveUtils {
  static Widget getLeaveBadge(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return Badge.success(text: status.convertToString().toUpperCase());
      case LeaveStatus.waiting:
        return Badge.warning(text: status.convertToString().toUpperCase());
      case LeaveStatus.cancelled:
        return Badge.error(text: status.convertToString().toUpperCase());
      case LeaveStatus.rejected:
        return Badge.error(text: status.convertToString().toUpperCase());
      default:
        return const SizedBox();
    }
  }
}
