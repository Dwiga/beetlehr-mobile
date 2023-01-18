import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../files.dart';

part 'upload_any_files_event.dart';
part 'upload_any_files_state.dart';

class UploadAnyFilesBloc
    extends Bloc<UploadAnyFilesEvent, UploadAnyFilesState> {
  UploadAnyFilesBloc(this.useCase) : super(UploadAnyFilesInitial());

  final UploadAnyFilesUseCase useCase;

  @override
  Stream<UploadAnyFilesState> mapEventToState(
    UploadAnyFilesEvent event,
  ) async* {
    if (event is GetUploadAnyFilesEvent) {
      yield* _mapUploadFilesToState(event);
    }
  }

  Stream<UploadAnyFilesState> _mapUploadFilesToState(
      GetUploadAnyFilesEvent event) async* {
    try {
      yield UploadAnyFilesInitial();
      yield UploadAnyFilesLoading();

      final result = await useCase(event.files);

      yield result.fold(
        (l) => UploadAnyFilesFailure(l),
        (r) => UploadAnyFilesSuccess(r),
      );
    } catch (e) {
      yield UploadAnyFilesFailure(CacheFailure(message: e.toString()));
    }
  }
}
