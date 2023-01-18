part of 'upload_photo_bloc.dart';

abstract class UploadPhotoState extends Equatable {}

class UploadPhotoInitial extends UploadPhotoState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UploadPhotoLoading extends UploadPhotoState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UploadPhotoFailure extends UploadPhotoState {
  final Failure failure;

  UploadPhotoFailure(this.failure);
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UploadPhotoSuccess extends UploadPhotoState {
  final AttendanceImageModel data;

  UploadPhotoSuccess(this.data);
  @override
  List<Object> get props => [data];

  @override
  bool get stringify => true;
}
