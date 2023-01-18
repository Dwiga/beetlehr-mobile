import '../../../../leave.dart';

class LeaveTypeModel extends LeaveTypeEntity {
  const LeaveTypeModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json["id"],
      name: json["name"],
    );
  }
}

extension LeaveTypeEntityX on LeaveTypeEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
