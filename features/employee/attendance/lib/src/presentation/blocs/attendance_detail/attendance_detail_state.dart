part of 'attendance_detail_bloc.dart';

abstract class AttendanceDetailState extends Equatable {
  const AttendanceDetailState();
}

class AttendanceDetailLoading extends AttendanceDetailState {
  @override
  List<Object> get props => [];
}

class AttendanceDetailSuccess extends AttendanceDetailState {
  final AttendanceDetailDataEntity data;

  const AttendanceDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AttendanceDetailFailure extends AttendanceDetailState {
  final Failure failure;

  const AttendanceDetailFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
