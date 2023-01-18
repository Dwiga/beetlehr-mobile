import 'package:dependencies/dependencies.dart';

class LeaveTypeEntity extends Equatable {
  const LeaveTypeEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}
