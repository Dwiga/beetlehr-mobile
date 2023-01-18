import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../../../attendance.dart';

part 'attendance_detail_event.dart';
part 'attendance_detail_state.dart';

class AttendanceDetailBloc
    extends Bloc<AttendanceDetailEvent, AttendanceDetailState> {
  final GetAttendanceDetailUseCase useCase;
  AttendanceDetailBloc(this.useCase) : super(AttendanceDetailLoading());

  @override
  Stream<AttendanceDetailState> mapEventToState(
    AttendanceDetailEvent event,
  ) async* {
    if (event is FetchAttendanceDetailEvent) {
      yield* _mapFetchAttendanceDetailToState(event);
    }
  }

  Stream<AttendanceDetailState> _mapFetchAttendanceDetailToState(
      FetchAttendanceDetailEvent event) async* {
    try {
      final result = await useCase(AttendanceDetailParams(event.date));
      yield* result.fold((l) async* {
        yield AttendanceDetailFailure(l);
      }, (r) async* {
        yield AttendanceDetailSuccess(r);
      });
    } catch (e) {
      yield AttendanceDetailFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
