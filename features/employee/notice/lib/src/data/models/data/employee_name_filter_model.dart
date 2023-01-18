import '../../../../notice.dart';

class EmployeeNameFilterModel extends EmployeeNameFilterEntity {
  const EmployeeNameFilterModel(
      {required int id,
      required String name,
      required String designation,
      required String placement,
      String? image})
      : super(
            id: id,
            name: name,
            designation: designation,
            placement: placement,
            image: image);

  factory EmployeeNameFilterModel.fromJson(Map<String, dynamic> json) {
    return EmployeeNameFilterModel(
        id: json['id'],
        name: json['name'],
        designation: json['designation'],
        placement: json['placement'],
        image: json['image']);
  }
}

extension EmployeeNameFilterModelX on EmployeeNameFilterEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'placment': placement,
      'image': image
    };
  }
}
