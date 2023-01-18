import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../../../notice.dart';

part 'approval_request_detail_event.dart';
part 'approval_request_detail_state.dart';

class ApprovalRequestDetailBloc
    extends Bloc<ApprovalRequestDetailEvent, ApprovalRequestDetailState> {
  final GetApprovalRequestDetailUseCase getApprovalRequestDetailUseCase;
  ApprovalRequestDetailBloc(this.getApprovalRequestDetailUseCase)
      : super(AttendanceDetailLoading());

  @override
  Stream<ApprovalRequestDetailState> mapEventToState(
    ApprovalRequestDetailEvent event,
  ) async* {
    if (event is FetchApprovalRequestDetailEvent) {
      yield* _mapFetchApprovalRequestDetailToState(event);
    }
  }

  Stream<ApprovalRequestDetailState> _mapFetchApprovalRequestDetailToState(
      FetchApprovalRequestDetailEvent event) async* {
    try {
      final result = await getApprovalRequestDetailUseCase(
          ApprovalRequestDetailParams(event.id, event.type));
      yield* result.fold((l) async* {
        yield ApprovalRequestDetailFailure(l);
      }, (r) async* {
        yield ApprovalRequestDetailSuccess(r);
      });
    } catch (e) {
      yield ApprovalRequestDetailFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
