import '../../../../attendance.dart';

class BreakTimeModel extends BreakTimeEntity {
  const BreakTimeModel({
    required int id,
    BreakTimeType? type,
    AttendanceImageModel? image,
    double? latitude,
    double? longitude,
    String? address,
    String? notes,
    List<String>? files,
  }) : super(
          id: id,
          type: type,
          image: image,
          latitude: latitude,
          longitude: longitude,
          address: address,
          notes: notes,
          files: files,
        );

  factory BreakTimeModel.fromJson(Map<String, dynamic> json) {
    return BreakTimeModel(
      id: json["id"],
      type: breakTimeTypefromString(json['type']),
      latitude: 0,
      longitude: 0,
      image: json["image"] != null
          ? AttendanceImageModel.fromJson(json["image"])
          : null,
      address: json["address"],
      files: json['files'] != null
          ? List<String>.from(json['files']).toList()
          : null,
      notes: json["notes"],
    );
  }
}

extension BreakTimeModelX on BreakTimeEntity {
  Map<String, dynamic> toJson() => {
        'id': address,
        'type': type,
        'image': image,
        'latitude': latitude,
        'longitude': longitude,
        'address': notes,
        'files': files,
      };
}
