import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../auth.dart';

part 'reset_pass_event.dart';
part 'reset_pass_state.dart';

class ResetPassBloc extends Bloc<ResetPassEvent, ResetPassState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  ResetPassBloc(this.resetPasswordUseCase) : super(const ResetPassState());

  @override
  Stream<ResetPassState> mapEventToState(
    ResetPassEvent event,
  ) async* {
    if (event is ResetPassEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is ResetPassSubmitted) {
      yield* _mapResetPassSubmittedToState(event, state);
    }
  }

  ResetPassState _mapEmailChangedToState(
    ResetPassEmailChanged event,
    ResetPassState state,
  ) {
    final email = EmailFormZ.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<ResetPassState> _mapResetPassSubmittedToState(
    ResetPassSubmitted event,
    ResetPassState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
      );
      try {
        final result = await resetPasswordUseCase(ResetPasswordParams(
          email: state.email.value,
        ));
        yield* result.fold((l) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: l,
          );
        }, (r) async* {
          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );
        });
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
        );
      }
    }
  }
}
