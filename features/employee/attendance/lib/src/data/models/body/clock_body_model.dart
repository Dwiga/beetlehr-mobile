import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class ClockBodyModel extends Equatable {
  const ClockBodyModel({
    this.date,
    required this.clock,
    required this.type,
    this.notes,
    required this.latitude,
    required this.longitude,
    required this.imageId,
    required this.address,
    this.overtimeId,
    this.filesId,
    required this.workingFrom,
  });

  final DateTime? date;
  final String clock;
  final AttendanceType type;
  final String? notes;
  final double latitude;
  final double longitude;
  final int imageId;
  final String address;
  final int? overtimeId;
  final List<int>? filesId;
  final WorkingFromType workingFrom;

  ClockBodyModel copyWith({
    DateTime? date,
    String? clock,
    AttendanceType? type,
    String? notes,
    double? latitude,
    double? longitude,
    int? imageId,
    String? address,
    int? overtimeId,
    List<int>? filesId,
    WorkingFromType? workingFrom,
  }) =>
      ClockBodyModel(
        date: date ?? this.date,
        clock: clock ?? this.clock,
        type: type ?? this.type,
        notes: notes ?? this.notes,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        imageId: imageId ?? this.imageId,
        address: address ?? this.address,
        overtimeId: overtimeId ?? this.overtimeId,
        filesId: filesId ?? this.filesId,
        workingFrom: workingFrom ?? this.workingFrom,
      );

  Map<String, dynamic> toJson() => {
        "date": date != null ? DateFormat('y-MM-dd').format(date!) : null,
        "clock": clock,
        "type": type.convertToString(),
        "notes": notes,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "image_id": imageId,
        "address": address,
        'overtime_id': overtimeId,
        "files": filesId,
        'status': workingFrom.convertToString(),
      };

  Map<String, dynamic> toJsonNoFiles() => {
        "date": date != null ? DateFormat('y-MM-dd').format(date!) : null,
        "clock": clock,
        "type": type.convertToString(),
        "notes": notes,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "image_id": imageId,
        "address": address,
        'overtime_id': overtimeId,
        'status': workingFrom.convertToString(),
      };

  @override
  List<Object?> get props => [
        date,
        clock,
        type,
        notes,
        latitude,
        longitude,
        imageId,
        address,
        overtimeId,
        filesId,
        workingFrom,
      ];

  @override
  bool get stringify => true;
}
