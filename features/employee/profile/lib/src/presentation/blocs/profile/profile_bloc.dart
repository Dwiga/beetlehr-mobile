import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase useCase;
  ProfileBloc(this.useCase) : super(ProfileLoading());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<ProfileState> _mapFetchDataToState(FetchProfileEvent event) async* {
    try {
      final _currentState = state;
      if (_currentState is ProfileSuccess && event.refresh != true) {
        return;
      }

      yield ProfileLoading();

      final result = await useCase(NoParams());

      yield result.fold(
        (l) => ProfileFailure(l),
        (r) => ProfileSuccess(r),
      );
    } catch (e) {
      yield ProfileFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
