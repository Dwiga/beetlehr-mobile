part of 'cancel_attendance_bloc.dart';

abstract class CancelAttendanceState extends Equatable {
  const CancelAttendanceState();

  @override
  List<Object?> get props => [];
}

class CancelAttendanceInitial extends CancelAttendanceState {
  const CancelAttendanceInitial();
}

class CancelAttendanceLoading extends CancelAttendanceState {
  const CancelAttendanceLoading();
}

class CancelAttendanceSuccess extends CancelAttendanceState {
  const CancelAttendanceSuccess();
}

class CancelAttendanceFailure extends CancelAttendanceState {
  const CancelAttendanceFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
