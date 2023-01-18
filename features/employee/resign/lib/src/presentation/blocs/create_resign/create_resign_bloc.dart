import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../resign.dart';
import '../../formz/formz.dart';

part 'create_resign_event.dart';
part 'create_resign_state.dart';

class CreateResignBloc extends Bloc<CreateResignEvent, CreateResignState> {
  final CreateResignUseCase useCase;
  CreateResignBloc(this.useCase) : super(const CreateResignState());

  @override
  Stream<CreateResignState> mapEventToState(
    CreateResignEvent event,
  ) async* {
    if (event is CreateResignChangeSubmitDate) {
      yield _mapSubmitDateChangeToState(event, state);
    } else if (event is CreateResignChangeContractDate) {
      yield _mapContractDateChangeToState(event, state);
    } else if (event is CreateResignChangeReason) {
      yield _mapReasonChangeToState(event, state);
    } else if (event is CreateResignChangeResignType) {
      yield _mapResignTypeChangeToState(event, state);
    } else if (event is CreateResignChangeFile) {
      yield _mapFileChangeToState(event, state);
    } else if (event is CreateResignSubmitted) {
      yield* _mapCreateResignSubmittedToState(event, state);
    }
  }

  CreateResignState _mapSubmitDateChangeToState(
    CreateResignChangeSubmitDate event,
    CreateResignState state,
  ) {
    final date = DateFormZ.dirty(event.date);
    return state.copyWith(
      submitDate: date,
      status: Formz.validate([
        date,
        state.endContractDate,
        state.reason,
        state.resignType,
        state.file,
      ]),
    );
  }

  CreateResignState _mapContractDateChangeToState(
    CreateResignChangeContractDate event,
    CreateResignState state,
  ) {
    final date = DateFormZ.dirty(event.date);
    return state.copyWith(
      endContractDate: date,
      status: Formz.validate([
        state.submitDate,
        date,
        state.reason,
        state.resignType,
        state.file,
      ]),
    );
  }

  CreateResignState _mapReasonChangeToState(
    CreateResignChangeReason event,
    CreateResignState state,
  ) {
    final reason = ReasonFormZ.dirty(event.reason);
    return state.copyWith(
      reason: reason,
      status: Formz.validate([
        state.submitDate,
        state.endContractDate,
        reason,
        state.resignType,
        state.file,
      ]),
    );
  }

  CreateResignState _mapResignTypeChangeToState(
    CreateResignChangeResignType event,
    CreateResignState state,
  ) {
    final resignType = ResignTypeFormZ.dirty(event.type);
    return state.copyWith(
      resignType: resignType,
      status: Formz.validate([
        state.submitDate,
        state.endContractDate,
        state.reason,
        resignType,
        state.file,
      ]),
    );
  }

  CreateResignState _mapFileChangeToState(
    CreateResignChangeFile event,
    CreateResignState state,
  ) {
    final file = FileFormZ.dirty(event.file);
    return state.copyWith(
      file: file,
      status: Formz.validate([
        state.submitDate,
        state.endContractDate,
        state.reason,
        state.resignType,
        file,
      ]),
    );
  }

  Stream<CreateResignState> _mapCreateResignSubmittedToState(
    CreateResignSubmitted event,
    CreateResignState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final result = await useCase(ResignBodyModel(
          date: state.submitDate.value!,
          endContract: state.endContractDate.value!,
          reason: state.reason.value,
          file: state.file.value!,
          isAccordingProcedure: state.resignType.value!,
        ));

        yield* result.fold((l) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: l,
          );
        }, (r) async* {
          yield state.copyWith(status: FormzStatus.submissionSuccess, data: r);
        });
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
