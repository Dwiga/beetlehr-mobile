part of 'upload_photo_bloc.dart';

abstract class UploadPhotoEvent extends Equatable {}

class CancelUploadPhotoEvent extends UploadPhotoEvent {
  @override
  List<Object> get props => [];
}

class GetUploadPhotoEvent extends UploadPhotoEvent {
  final File image;
  final DateTime date;
  final AttendanceClockType type;
  final WorkingFromType workingFrom;

  GetUploadPhotoEvent({
    required this.image,
    required this.date,
    required this.type,
    required this.workingFrom,
  });

  @override
  List<Object> get props => [image, date, type, workingFrom];

  @override
  bool get stringify => true;
}
