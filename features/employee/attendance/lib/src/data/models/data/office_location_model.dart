import 'package:core/core.dart';

import '../../../../attendance.dart';

class OfficePlacementModel extends OfficePlacementEntity {
  const OfficePlacementModel({
    required String address,
    required double placementLatitude,
    required double placementLongitude,
    required double maxRadius,
    required bool accepted,
    required WorkingFromType workingFrom,
  }) : super(
          address: address,
          placementLatitude: placementLatitude,
          placementLongitude: placementLongitude,
          maxRadius: maxRadius,
          accepted: accepted,
          workingFrom: workingFrom,
        );

  factory OfficePlacementModel.fromJson(Map<String, dynamic> json) {
    return OfficePlacementModel(
        address: json['address'],
        placementLatitude: Utils.doubleParser(json['placement_latitude']) ?? 0,
        placementLongitude:
            Utils.doubleParser(json['placement_longitude']) ?? 0,
        maxRadius: Utils.doubleParser(json['max_radius']) ?? 0,
        accepted: json['accepted'],
        workingFrom: workingFromTypefromString(json['status']) ??
            WorkingFromType.office);
  }
}

extension OfficePlacementModelX on OfficePlacementEntity {
  Map<String, dynamic> toJson() => {
        'address': address,
        'placement_latitude': placementLatitude,
        'placement_longitude': placementLongitude,
        'max_radius': maxRadius,
        'accepted': accepted,
      };
}
