part of 'attendance_log_bloc.dart';

abstract class AttendanceLogState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AttendanceLogLoading extends AttendanceLogState {}

class AttendanceLogSuccess extends AttendanceLogState {
  final List<AttendanceEntity> data;
  final DateTime period;

  AttendanceLogSuccess({
    required this.data,
    required this.period,
  });

  @override
  List<Object> get props => [data, period];
}

class AttendanceLogFailure extends AttendanceLogState {
  final Failure failure;

  AttendanceLogFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
