part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
}

class AttendanceInitial extends AttendanceState {
  @override
  List<Object> get props => [];
}

class AttendanceLoading extends AttendanceState {
  @override
  List<Object> get props => [];
}

class AttendanceFailure extends AttendanceState {
  final Failure failure;

  const AttendanceFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AttendanceSuccess extends AttendanceState {
  final AttendanceResponseModel data;

  const AttendanceSuccess(this.data);

  @override
  List<Object> get props => [data];
}
