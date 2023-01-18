import 'package:dependencies/dependencies.dart';
import 'package:intl/intl.dart';

import '../../../../attendance.dart';

class ScheduleModel extends ScheduleEntity {
  const ScheduleModel({
    required int id,
    required DateTime date,
    int? isLeave,
    required String? timeStart,
    required String? timeEnd,
    required String? name,
  }) : super(
          id: id,
          date: date,
          isLeave: isLeave,
          timeStart: timeStart,
          timeEnd: timeEnd,
          name: name,
        );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        date: DateTime.parse(json["date"]).toLocal(),
        isLeave: json["is_leave"],
        timeStart: json['shift'] != null ? json['shift']['time_start'] : null,
        timeEnd: json['shift'] != null ? json['shift']['time_end'] : null,
        name: json['shift'] != null ? json['shift']['name'] : null,
      );
}

extension ScheduleModelX on ScheduleEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": DateFormat('y-MM-dd').format(date),
        "is_leave": isLeave,
        "shift": {
          'time_start': timeStart,
          'time_end': timeEnd,
          'name': name,
        },
      };
}
