part of 'pending_attendances_bloc.dart';

abstract class PendingAttendancesState extends Equatable {
  const PendingAttendancesState();

  @override
  List<Object?> get props => [];
}

class PendingAttendancesLoading extends PendingAttendancesState {}

class PendingAttendancesSuccess extends PendingAttendancesState {
  final List<AttendanceOfflineDataEntity> data;

  const PendingAttendancesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class PendingAttendancesFailure extends PendingAttendancesState {
  final Failure failure;

  const PendingAttendancesFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
