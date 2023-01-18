part of 'attendance_overview_bloc.dart';

abstract class AttendanceOverviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class AttendanceOverviewLoading extends AttendanceOverviewState {}

class AttendanceOverviewFailure extends AttendanceOverviewState {
  final Failure failure;

  AttendanceOverviewFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AttendanceOverviewSuccess extends AttendanceOverviewState {
  final AttendanceOverviewEntity data;
  AttendanceOverviewSuccess({
    required this.data,
  });
}
