part of 'upload_any_files_bloc.dart';

abstract class UploadAnyFilesState extends Equatable {}

class UploadAnyFilesInitial extends UploadAnyFilesState {
  @override
  List<Object?> get props => [];
}

class UploadAnyFilesLoading extends UploadAnyFilesState {
  @override
  List<Object?> get props => [];
}

class UploadAnyFilesFailure extends UploadAnyFilesState {
  final Failure failure;

  UploadAnyFilesFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

class UploadAnyFilesSuccess extends UploadAnyFilesState {
  final List<NetworkFileEntity> data;

  UploadAnyFilesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}
