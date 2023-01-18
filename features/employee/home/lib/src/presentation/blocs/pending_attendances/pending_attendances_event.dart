part of 'pending_attendances_bloc.dart';

abstract class PendingAttendancesEvent extends Equatable {
  const PendingAttendancesEvent();

  @override
  List<Object?> get props => [];
}

class PendingAttendancesFetched extends PendingAttendancesEvent {
  final bool refresh;

  const PendingAttendancesFetched({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}
