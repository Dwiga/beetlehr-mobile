import 'package:dependencies/dependencies.dart';

class EmployeeNameFilterEntity extends Equatable {
  final int id;
  final String name;
  final String designation;
  final String placement;
  final String? image;

  const EmployeeNameFilterEntity(
      {required this.id,
      required this.name,
      required this.designation,
      required this.placement,
      this.image});

  @override
  List<Object?> get props => [id, name, designation, placement, image];

  @override
  bool get stringify => true;
}
