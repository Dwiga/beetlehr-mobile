enum AttendanceLogType {
  present,
  late,
  earlyClockOut,
  leave,
  holiday,
  absent,
}

AttendanceLogType? attendanceLogTypeFromString(String type) {
  switch (type) {
    case 'present':
      return AttendanceLogType.present;
    case 'late':
      return AttendanceLogType.late;
    case 'early_clock_out':
      return AttendanceLogType.earlyClockOut;
    case 'leave':
      return AttendanceLogType.leave;
    case 'holiday':
      return AttendanceLogType.holiday;
    case 'absent':
      return AttendanceLogType.absent;
  }
  return null;
}

extension AttendanceLogTypeX on AttendanceLogType {
  String convertToString() {
    switch (this) {
      case AttendanceLogType.present:
        return 'present';
      case AttendanceLogType.late:
        return 'late';
      case AttendanceLogType.earlyClockOut:
        return 'early_clock_out';
      case AttendanceLogType.leave:
        return 'leave';
      case AttendanceLogType.holiday:
        return 'holiday';
      case AttendanceLogType.absent:
        return 'absent';
    }
  }
}
