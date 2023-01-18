part of 'check_attendance_bloc.dart';

abstract class CheckAttendanceState extends Equatable {
  const CheckAttendanceState();
}

class CheckAttendanceInitial extends CheckAttendanceState {
  @override
  List<Object> get props => [];
}

class CheckAttendanceLoading extends CheckAttendanceState {
  @override
  List<Object> get props => [];
}

class CheckAttendanceSuccess extends CheckAttendanceState {
  final AttendanceType type;
  final bool isAccept;
  final WorkingFromType workingFrom;

  const CheckAttendanceSuccess({
    required this.type,
    required this.isAccept,
    required this.workingFrom,
  });

  @override
  List<Object> get props => [type, isAccept, workingFrom];
}

class CheckAttendanceFailure extends CheckAttendanceState {
  final Failure failure;

  const CheckAttendanceFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
