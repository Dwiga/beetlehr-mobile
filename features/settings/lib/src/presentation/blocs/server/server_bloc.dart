import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../settings.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<CheckServerEvent, CheckServerState> {
  final CheckServerUseCase useCase;
  final ServerRepository repository;
  ServerBloc({required this.useCase, required this.repository})
      : super(CheckServerInitial());

  @override
  Stream<CheckServerState> mapEventToState(
    CheckServerEvent event,
  ) async* {
    if (event is FetchCheckServerEvent) {
      yield* _mapFetchServer(event);
    }
  }

  Stream<CheckServerState> _mapFetchServer(FetchCheckServerEvent event) async* {
    try {
      yield CheckServerLoading();
      final result = await useCase(
          ServerParams(domain: event.endpoint, schema: event.schema));

      yield* result.fold((l) async* {
        yield CheckServerFailure(l);
      }, (r) async* {
        yield CheckServerSuccess(r);
        await repository.setSavedServerInfo(r);
      });
    } catch (e) {
      yield CheckServerFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
