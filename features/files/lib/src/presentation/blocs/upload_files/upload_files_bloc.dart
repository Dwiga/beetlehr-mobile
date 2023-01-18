import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

import '../../../../files.dart';

part 'upload_files_event.dart';
part 'upload_files_state.dart';

class UploadFilesBloc extends Bloc<UploadFilesEvent, UploadFilesState> {
  UploadFilesBloc(this.useCase) : super(UploadFilesInitial());

  final UploadFilesUseCase useCase;

  @override
  Stream<UploadFilesState> mapEventToState(
    UploadFilesEvent event,
  ) async* {
    if (event is GetUploadFilesEvent) {
      yield* _mapUploadFilesToState(event);
    }
  }

  Stream<UploadFilesState> _mapUploadFilesToState(
      GetUploadFilesEvent event) async* {
    try {
      yield UploadFilesInitial();
      yield UploadFilesLoading();

      final result = await useCase(event.files);

      yield result.fold(
        (l) => UploadFilesFailure(l),
        (r) => UploadFilesSuccess(r),
      );
    } catch (e, stackTrace) {
      GetIt.I<RecordErrorUseCase>()(
        RecordErrorParams(exception: e, stackTrace: stackTrace),
      );
      yield UploadFilesFailure(CacheFailure(message: e.toString()));
    }
  }
}
