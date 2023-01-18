import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../leave.dart';
import '../../formz/formz.dart';

part 'create_leave_event.dart';
part 'create_leave_state.dart';

class CreateLeaveBloc extends Bloc<CreateLeaveEvent, CreateLeaveState> {
  final CreateLeaveUseCase useCase;
  CreateLeaveBloc(this.useCase) : super(const CreateLeaveState());

  @override
  Stream<CreateLeaveState> mapEventToState(
    CreateLeaveEvent event,
  ) async* {
    if (event is CreateLeaveChangeType) {
      yield _mapChangeTypeToState(event, state);
    } else if (event is CreateLeaveChangeDateFrom) {
      yield _mapChangeDateFromToState(event, state);
    } else if (event is CreateLeaveChangeDateUntil) {
      yield _mapChangeDateUntilToState(event, state);
    } else if (event is CreateLeaveChangeReason) {
      yield _mapChangeReasonToState(event, state);
    } else if (event is CreateLeaveChangeFile) {
      yield _mapChangeFileToState(event, state);
    } else if (event is CreateLeaveSubmitted) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  CreateLeaveState _mapChangeTypeToState(
    CreateLeaveChangeType event,
    CreateLeaveState state,
  ) {
    final leaveType = LeaveTypeFormZ.dirty(event.typeId);
    return state.copyWith(
      leaveType: leaveType,
      status: Formz.validate([
        leaveType,
        state.dateFrom,
        state.dateUntil,
        state.reason,
        state.file,
      ]),
    );
  }

  CreateLeaveState _mapChangeDateFromToState(
    CreateLeaveChangeDateFrom event,
    CreateLeaveState state,
  ) {
    final dateFrom = DateFromFormZ.dirty(event.date);
    return state.copyWith(
      dateFrom: dateFrom,
      status: Formz.validate([
        state.leaveType,
        dateFrom,
        state.dateUntil,
        state.reason,
        state.file,
      ]),
    );
  }

  CreateLeaveState _mapChangeDateUntilToState(
    CreateLeaveChangeDateUntil event,
    CreateLeaveState state,
  ) {
    final dateUntil = DateUntilFormZ.dirty(
      value: event.date,
      startDate: event.startDate,
    );
    return state.copyWith(
      dateUntil: dateUntil,
      status: Formz.validate([
        state.leaveType,
        state.dateFrom,
        dateUntil,
        state.reason,
        state.file,
      ]),
    );
  }

  CreateLeaveState _mapChangeReasonToState(
    CreateLeaveChangeReason event,
    CreateLeaveState state,
  ) {
    final reason = ReasonFormZ.dirty(event.reason);
    return state.copyWith(
      reason: reason,
      status: Formz.validate([
        state.leaveType,
        state.dateFrom,
        state.dateUntil,
        reason,
        state.file,
      ]),
    );
  }

  CreateLeaveState _mapChangeFileToState(
    CreateLeaveChangeFile event,
    CreateLeaveState state,
  ) {
    final file = FileFormZ.dirty(event.file);
    return state.copyWith(
      file: file,
      status: Formz.validate([
        state.leaveType,
        state.dateFrom,
        state.dateUntil,
        state.reason,
        file,
      ]),
    );
  }

  Stream<CreateLeaveState> _mapSubmittedToState(
    CreateLeaveSubmitted event,
    CreateLeaveState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final result = await useCase(LeaveBodyModel(
          leaveTypeId: state.leaveType.value ?? 0,
          startDate: state.dateFrom.value,
          endDate: state.dateUntil.value,
          reason: state.reason.value,
          file: state.file.value,
        ));

        yield* result.fold((l) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: l,
          );
        }, (r) async* {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        });
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
