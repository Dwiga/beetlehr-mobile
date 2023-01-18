part of 'create_leave_bloc.dart';

class CreateLeaveState extends Equatable {
  const CreateLeaveState({
    this.leaveType = const LeaveTypeFormZ.pure(),
    this.dateFrom = const DateFromFormZ.pure(),
    this.dateUntil = const DateUntilFormZ.pure(),
    this.reason = const ReasonFormZ.pure(),
    this.file = const FileFormZ.pure(),
    this.status = FormzStatus.pure,
    this.failure,
  });

  final LeaveTypeFormZ leaveType;
  final DateFromFormZ dateFrom;
  final DateUntilFormZ dateUntil;
  final ReasonFormZ reason;
  final FileFormZ file;
  final FormzStatus status;
  final Failure? failure;

  CreateLeaveState copyWith({
    LeaveTypeFormZ? leaveType,
    DateFromFormZ? dateFrom,
    DateUntilFormZ? dateUntil,
    ReasonFormZ? reason,
    FileFormZ? file,
    FormzStatus? status,
    Failure? failure,
  }) {
    return CreateLeaveState(
      leaveType: leaveType ?? this.leaveType,
      dateFrom: dateFrom ?? this.dateFrom,
      dateUntil: dateUntil ?? this.dateUntil,
      reason: reason ?? this.reason,
      file: file ?? this.file,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        leaveType,
        dateFrom,
        dateUntil,
        reason,
        file,
        status,
        failure,
      ];
}
