import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../files.dart';

part 'download_file_event.dart';
part 'download_file_state.dart';

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  DownloadFileBloc(this.useCase) : super(DownloadFileInitial());

  final DownloadFileUseCase useCase;

  @override
  Stream<DownloadFileState> mapEventToState(
    DownloadFileEvent event,
  ) async* {
    if (event is GetDownloadFileEvent) {
      yield* _mapDownloadFileToState(event);
    }
  }

  Stream<DownloadFileState> _mapDownloadFileToState(
      GetDownloadFileEvent event) async* {
    try {
      yield DownloadFileInitial();
      yield DownloadFileLoading();

      final result = await useCase(
        DownloadFileParams(
          event.url,
          fileName: event.fileName,
          savePath: event.savePath,
          showNotification: event.showNotification ?? false,
          withHttpClint: event.withHttpClient,
        ),
      );

      yield result.fold(
        (l) => DownloadFileFailure(l),
        (r) => DownloadFileSuccess(r),
      );
    } catch (e) {
      yield DownloadFileFailure(CacheFailure(message: e.toString()));
    }
  }
}
