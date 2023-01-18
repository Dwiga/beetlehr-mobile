part of 'leave_type_bloc.dart';

abstract class LeaveTypeEvent extends Equatable {}

class FetchLeaveTypeEvent extends LeaveTypeEvent {
  final int page;
  final int perPage;
  FetchLeaveTypeEvent({
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [];
}
