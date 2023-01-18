enum AttendanceClockType {
  clockIn,
  clockOut,
  clockOutRaw,
}

AttendanceClockType? attendanceClockTypefromString(String? type) {
  switch (type) {
    case 'in':
    case 'clockin':
      return AttendanceClockType.clockIn;
    case 'out':
    case 'clockout':
      return AttendanceClockType.clockOut;
    default:
      return null;
  }
}

extension AttendanceClockTypeX on AttendanceClockType {
  String convertToString() {
    switch (this) {
      case AttendanceClockType.clockIn:
        return 'in';
      case AttendanceClockType.clockOut:
        return 'out';
      case AttendanceClockType.clockOutRaw:
        return 'clockout';
    }
  }
}
