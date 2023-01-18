import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';

part 'leave_type_event.dart';
part 'leave_type_state.dart';

class LeaveTypeBloc extends Bloc<LeaveTypeEvent, LeaveTypeState> {
  final GetLeaveTypeUseCase useCase;
  LeaveTypeBloc(this.useCase) : super(LeaveTypeLoading());

  @override
  Stream<LeaveTypeState> mapEventToState(
    LeaveTypeEvent event,
  ) async* {
    if (event is FetchLeaveTypeEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<LeaveTypeState> _mapFetchDataToState(
      FetchLeaveTypeEvent event) async* {
    try {
      yield LeaveTypeLoading();
      final result = await useCase(PaginateParams(
        page: event.page,
        perPage: event.perPage,
      ));

      yield* result.fold((l) async* {
        yield LeaveTypeFailure(l);
      }, (r) async* {
        yield LeaveTypeSuccess(r.data);
      });
    } catch (e) {
      yield LeaveTypeFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
