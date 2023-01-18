import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class CheckAcceptClockBodyModel extends Equatable {
  const CheckAcceptClockBodyModel({
    required this.date,
    required this.clock,
    required this.type,
    this.overtimeId,
  });

  final DateTime date;
  final String clock;
  final AttendanceType type;
  final int? overtimeId;

  Map<String, dynamic> toJson() => {
        "date": DateFormat('y-MM-dd').format(date),
        "clock": clock,
        "type": type.convertToString(),
        'overtime_id': overtimeId,
      };

  @override
  List<Object> get props => [date, clock, type];

  @override
  bool get stringify => true;
}
