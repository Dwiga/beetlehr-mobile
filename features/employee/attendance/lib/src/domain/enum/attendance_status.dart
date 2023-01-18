// enum AttendanceStatus {
//   absent,
//   present,
//   holiday,
//   late,
// }

// AttendanceStatus? attendanceStatusfromString(String? type) {
//   switch (type) {
//     case 'absent':
//       return AttendanceStatus.absent;
//     case 'present':
//       return AttendanceStatus.present;
//     case 'holiday':
//       return AttendanceStatus.holiday;
//     case 'late':
//       return AttendanceStatus.late;
//     default:
//       return null;
//   }
// }

// extension AttendanceStatusX on AttendanceStatus {
//   String convertToString() {
//     switch (this) {
//       case AttendanceStatus.absent:
//         return 'absent';
//       case AttendanceStatus.present:
//         return 'present';
//       case AttendanceStatus.holiday:
//         return 'holiday';
//       case AttendanceStatus.late:
//         return 'late';
//     }
//   }
// }
