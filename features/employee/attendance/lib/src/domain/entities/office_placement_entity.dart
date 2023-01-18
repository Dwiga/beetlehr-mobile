import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class OfficePlacementEntity extends Equatable {
  final String address;
  final double placementLatitude;
  final double placementLongitude;
  final double maxRadius;
  final bool accepted;
  final WorkingFromType workingFrom;

  const OfficePlacementEntity({
    required this.address,
    required this.placementLatitude,
    required this.placementLongitude,
    required this.maxRadius,
    required this.accepted,
    required this.workingFrom,
  });

  @override
  List<Object> get props => [
        address,
        placementLatitude,
        placementLongitude,
        maxRadius,
        accepted,
        workingFrom,
      ];

  @override
  bool get stringify => true;
}
