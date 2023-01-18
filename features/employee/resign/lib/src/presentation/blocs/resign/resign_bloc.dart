import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../resign.dart';

part 'resign_event.dart';
part 'resign_state.dart';

class ResignBloc extends Bloc<ResignEvent, ResignState> {
  final GetResignUseCase useCase;
  ResignBloc(this.useCase) : super(ResignLoading());

  @override
  Stream<ResignState> mapEventToState(
    ResignEvent event,
  ) async* {
    yield* _mapFetchDataToState();
  }

  Stream<ResignState> _mapFetchDataToState() async* {
    try {
      yield ResignLoading();

      final result = await useCase(NoParams());

      yield result.fold(
        (l) => ResignFailure(l),
        (r) => ResignSuccess(r),
      );
    } catch (e) {
      yield ResignFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
