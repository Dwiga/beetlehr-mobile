import 'package:dependencies/dependencies.dart';

part 'connection_mode_event.dart';

enum ConnectionMode { loading, online, offline }

class ConnectionModeBloc extends Bloc<ConnectionModeEvent, ConnectionMode> {
  ConnectionModeBloc() : super(ConnectionMode.loading) {
    on<ConnectionModeChanged>((event, emit) {
      if (event.refresh) {
        emit(ConnectionMode.loading);
      }
      emit(event.connectionMode);
    });

    on<ConnectionModeRefreshed>((event, emit) async {
      final prevState = state;
      emit(ConnectionMode.loading);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(prevState);
    });
  }
}
