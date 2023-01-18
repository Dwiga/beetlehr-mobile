import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class BreakTimeBodyModel extends Equatable {
  const BreakTimeBodyModel(
      {required this.date,
      required this.clock,
      required this.type,
      this.notes,
      this.latitude,
      this.longitude,
      this.imageId,
      this.address,
      this.files});

  final String date;
  final String clock;
  final BreakTimeType type;
  final String? notes;
  final String? latitude;
  final String? longitude;
  final int? imageId;
  final String? address;
  final List<String>? files;

  Map<String, dynamic> toJson() => {
        "date": date,
        "clock": clock,
        "type": type.convertToString(),
        "notes": notes,
        "latitude": latitude,
        "longitude": longitude,
        "image_id": imageId,
        "address": address,
        "files": files,
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
        files,
      ];

  @override
  bool get stringify => true;
}
