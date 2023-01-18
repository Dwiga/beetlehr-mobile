import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

part 'upload_photo_event.dart';
part 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadAttendanceImageUseCase uploadAttendanceImageUseCase;
  UploadPhotoBloc(this.uploadAttendanceImageUseCase)
      : super(UploadPhotoInitial());

  @override
  Stream<UploadPhotoState> mapEventToState(
    UploadPhotoEvent event,
  ) async* {
    if (event is CancelUploadPhotoEvent) {
      yield UploadPhotoInitial();
    } else if (event is GetUploadPhotoEvent) {
      yield* _mapGetUploadPhotoToState(event);
    }
  }

  Stream<UploadPhotoState> _mapGetUploadPhotoToState(
      GetUploadPhotoEvent event) async* {
    try {
      yield UploadPhotoLoading();
      final result = await uploadAttendanceImageUseCase(
        UploadAttendanceImageBodyModel(
          date: event.date,
          image: event.image,
          type: event.type,
          workingFrom: event.workingFrom,
        ),
      );

      yield* result.fold((l) async* {
        yield UploadPhotoFailure(l);
      }, (r) async* {
        yield UploadPhotoSuccess(r);
      });
    } catch (e) {
      yield UploadPhotoFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
