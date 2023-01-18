part of 'break_time_bloc.dart';

abstract class BreakTimeEvent extends Equatable {
  const BreakTimeEvent();
}

class FetchBreakTimeEvent extends BreakTimeEvent {
  final DateTime date;
  final DateTime clock;
  final BreakTimeType type;
  final String? notes;
  final String? latitude;
  final String? longitude;
  final String? address;
  final List<String> files;

  const FetchBreakTimeEvent({
    required this.date,
    required this.clock,
    required this.type,
    this.notes,
    this.latitude,
    this.longitude,
    this.address,
    required this.files,
  });

  @override
  List<Object> get props => [
        date,
        clock,
        type,
        latitude.toString(),
        longitude.toString(),
        address.toString(),
        notes.toString(),
        files
      ];
}
