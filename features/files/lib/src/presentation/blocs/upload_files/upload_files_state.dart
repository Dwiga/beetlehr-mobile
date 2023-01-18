part of 'upload_files_bloc.dart';

abstract class UploadFilesState extends Equatable {}

class UploadFilesInitial extends UploadFilesState {
  @override
  List<Object?> get props => [];
}

class UploadFilesLoading extends UploadFilesState {
  @override
  List<Object?> get props => [];
}

class UploadFilesFailure extends UploadFilesState {
  final Failure failure;

  UploadFilesFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

class UploadFilesSuccess extends UploadFilesState {
  final List<NetworkFileEntity> data;

  UploadFilesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}
