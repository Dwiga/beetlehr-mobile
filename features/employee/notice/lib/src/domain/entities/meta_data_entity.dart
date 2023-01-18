import 'package:dependencies/dependencies.dart';

class MetaDataEntity extends Equatable {
  final String startDate;
  final String endDate;
  final int duration;

  const MetaDataEntity(
      {required this.startDate, required this.endDate, required this.duration});

  @override
  List<Object> get props => [startDate, endDate, duration];

  @override
  bool get stringify => true;
}
