import 'package:attendance/attendance.dart';
import 'package:dependencies/dependencies.dart';

class CheckPlacementBodyModel extends Equatable {
  final double latitude;
  final double longitude;
  final WorkingFromType workingFrom;

  const CheckPlacementBodyModel({
    required this.latitude,
    required this.longitude,
    required this.workingFrom,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'status': workingFrom.convertToString(),
      };

  @override
  List<Object> get props => [latitude, longitude, workingFrom];
}
