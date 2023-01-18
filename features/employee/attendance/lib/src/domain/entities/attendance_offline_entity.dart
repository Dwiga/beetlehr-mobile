import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class AttendanceOfflineEntity extends Equatable {
  final DateTime date;
  final String clock;
  final AttendanceClockType type;
  final WorkingFromType workFrom;
  final String notes;
  final double latitude;
  final double longitude;
  final int? imageId;
  final String? localImage;
  final bool isSynced;

  const AttendanceOfflineEntity({
    required this.date,
    required this.clock,
    required this.type,
    required this.workFrom,
    required this.notes,
    required this.latitude,
    required this.longitude,
    this.imageId,
    required this.localImage,
    this.isSynced = false,
  });

  AttendanceOfflineEntity copyWith({
    DateTime? date,
    String? clock,
    AttendanceClockType? type,
    WorkingFromType? workFrom,
    String? notes,
    double? latitude,
    double? longitude,
    int? imageId,
    String? localImage,
    bool? isSynced,
  }) {
    return AttendanceOfflineEntity(
      date: date ?? this.date,
      clock: clock ?? this.clock,
      type: type ?? this.type,
      workFrom: workFrom ?? this.workFrom,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageId: imageId ?? this.imageId,
      localImage: localImage ?? this.localImage,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  List<Object?> get props => [
        date,
        clock,
        type,
        workFrom,
        notes,
        latitude,
        longitude,
        imageId,
        localImage,
        isSynced
      ];
}
