part of 'cancel_attendance_bloc.dart';

abstract class CancelAttendanceEvent extends Equatable {
  const CancelAttendanceEvent();
}

class CancelAttendanceSubmitted extends CancelAttendanceEvent {
  const CancelAttendanceSubmitted();

  @override
  List<Object?> get props => [];
}
