import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';
import 'package:settings/src/presentation/formz/formz.dart';

part 'url_setting_event.dart';
part 'url_setting_state.dart';

class UrlSettingBloc extends Bloc<UrlSettingEvent, UrlSettingState> {
  UrlSettingBloc(this.useCase) : super(const UrlSettingState());

  final SetBaseUrlUseCase useCase;

  @override
  Stream<UrlSettingState> mapEventToState(
    UrlSettingEvent event,
  ) async* {
    if (event is ChangeUrlSettingEvent) {
      yield _mapUrlChangedToState(event, state);
    } else if (event is UrlSettingSubmittedEvent) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  UrlSettingState _mapUrlChangedToState(
    ChangeUrlSettingEvent event,
    UrlSettingState state,
  ) {
    final url = URLFormZ.dirty(event.url);
    return state.copyWith(
      url: url,
      schema: event.schema,
      status: Formz.validate([url]),
    );
  }

  Stream<UrlSettingState> _mapSubmittedToState(
      UrlSettingSubmittedEvent event, UrlSettingState state) async* {
    try {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        final result = await useCase.call(
            SetBaseUrlParams(domain: state.url.value, schema: state.schema));

        yield result.fold(
          (l) => state.copyWith(
            failure: l,
            status: FormzStatus.submissionFailure,
          ),
          (r) => state.copyWith(
            status: FormzStatus.submissionSuccess,
          ),
        );
      }
    } catch (e) {
      yield state.copyWith(
        failure: DefaultServerFailure(message: e.toString()),
        status: FormzStatus.submissionFailure,
      );
    }
  }
}
