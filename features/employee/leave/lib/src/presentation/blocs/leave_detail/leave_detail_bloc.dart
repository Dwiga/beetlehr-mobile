import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';

part 'leave_detail_event.dart';
part 'leave_detail_state.dart';

class LeaveDetailBloc extends Bloc<LeaveDetailEvent, LeaveDetailState> {
  final GetDetailLeaveUseCase useCase;
  LeaveDetailBloc(this.useCase) : super(LeaveDetailLoading());

  @override
  Stream<LeaveDetailState> mapEventToState(
    LeaveDetailEvent event,
  ) async* {
    if (event is FetchLeaveDetailEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<LeaveDetailState> _mapFetchDataToState(
      FetchLeaveDetailEvent event) async* {
    try {
      yield LeaveDetailLoading();
      final result = await useCase(event.id);

      yield* result.fold((l) async* {
        yield LeaveDetailFailure(l);
      }, (r) async* {
        yield LeaveDetailSuccess(r);
      });
    } catch (e) {
      yield LeaveDetailFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
