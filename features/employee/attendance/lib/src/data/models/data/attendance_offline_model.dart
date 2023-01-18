import 'package:attendance/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

class AttendanceOfflineModel extends AttendanceOfflineEntity {
  const AttendanceOfflineModel({
    required DateTime date,
    required String clock,
    required AttendanceClockType type,
    required WorkingFromType workFrom,
    required String notes,
    required double latitude,
    required double longitude,
    int? imageId,
    required String? localImage,
    required bool isSynced,
  }) : super(
          date: date,
          clock: clock,
          type: type,
          workFrom: workFrom,
          notes: notes,
          latitude: latitude,
          longitude: longitude,
          imageId: imageId,
          localImage: localImage,
          isSynced: isSynced,
        );

  factory AttendanceOfflineModel.fromJson(Map<String, dynamic> json) {
    return AttendanceOfflineModel(
      date: DateTime.parse(json['date']),
      clock: json['clock'] ?? '',
      type: attendanceClockTypefromString(json['type'])!,
      workFrom: workingFromTypefromString('status') ?? WorkingFromType.anywhere,
      notes: json['notes'],
      latitude: Utils.doubleParser(json['latitude']) ?? 0,
      longitude: Utils.doubleParser(json['longitude']) ?? 0,
      localImage: json['local_image'],
      isSynced: json['isSynced'],
      imageId: Utils.intParser(json['image_id'] ?? ''),
    );
  }
}

extension AttendanceOfflineModelExtension on AttendanceOfflineEntity {
  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('yyyy-MM-dd').format(date),
      'type': type.convertToString(),
      'clock': clock,
      'status': workFrom.convertToString(),
      'notes': notes,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'local_image': localImage,
      'isSynced': isSynced,
      'image_id': imageId,
    };
  }
}
