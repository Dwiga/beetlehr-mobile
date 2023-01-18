import 'package:dependencies/dependencies.dart';

import '../domain.dart';

class BreakTimeEntity extends Equatable {
  final int id;
  final BreakTimeType? type;
  final AttendanceImageEntity? image;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? notes;
  final List<String>? files;

  const BreakTimeEntity({
    required this.id,
    this.type,
    this.image,
    this.latitude,
    this.longitude,
    this.address,
    this.notes,
    this.files,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        image,
        latitude,
        longitude,
        address,
        notes,
        files,
      ];

  @override
  bool get stringify => true;
}
