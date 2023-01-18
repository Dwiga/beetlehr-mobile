import 'package:dependencies/dependencies.dart';

class ScheduleEntity extends Equatable {
  final int id;
  final DateTime date;
  final int? isLeave;
  final String? timeStart;
  final String? timeEnd;
  final String? name;

  const ScheduleEntity({
    required this.id,
    required this.date,
    this.isLeave,
    required this.timeStart,
    required this.timeEnd,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        isLeave,
        timeStart,
        timeEnd,
        name,
      ];

  @override
  bool get stringify => true;
}
