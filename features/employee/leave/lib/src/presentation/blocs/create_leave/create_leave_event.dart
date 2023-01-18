part of 'create_leave_bloc.dart';

abstract class CreateLeaveEvent extends Equatable {}

class CreateLeaveChangeType extends CreateLeaveEvent {
  final int typeId;

  CreateLeaveChangeType(this.typeId);
  @override
  List<Object> get props => [typeId];
}

class CreateLeaveChangeDateFrom extends CreateLeaveEvent {
  final DateTime date;

  CreateLeaveChangeDateFrom(this.date);
  @override
  List<Object> get props => [date];
}

class CreateLeaveChangeDateUntil extends CreateLeaveEvent {
  final DateTime date;
  final DateTime startDate;

  CreateLeaveChangeDateUntil(this.date, this.startDate);
  @override
  List<Object> get props => [date, startDate];
}

class CreateLeaveChangeReason extends CreateLeaveEvent {
  final String reason;

  CreateLeaveChangeReason(this.reason);
  @override
  List<Object> get props => [reason];
}

class CreateLeaveChangeFile extends CreateLeaveEvent {
  final File file;

  CreateLeaveChangeFile(this.file);
  @override
  List<Object> get props => [file];
}

class CreateLeaveSubmitted extends CreateLeaveEvent {
  @override
  List<Object> get props => [];
}
