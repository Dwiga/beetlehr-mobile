enum AttendanceType {
  normal,
  clockOut,
}

AttendanceType? attendanceTypefromString(String? type) {
  switch (type) {
    case 'normal':
      return AttendanceType.normal;
    case 'clockout':
      return AttendanceType.clockOut;
    default:
      return null;
  }
}

extension AttendanceTypeX on AttendanceType {
  String convertToString() {
    switch (this) {
      case AttendanceType.normal:
        return 'normal';
      case AttendanceType.clockOut:
        return 'clockout';
    }
  }
}
