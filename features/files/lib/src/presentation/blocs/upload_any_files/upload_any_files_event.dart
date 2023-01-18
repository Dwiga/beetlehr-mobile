part of 'upload_any_files_bloc.dart';

abstract class UploadAnyFilesEvent extends Equatable {}

class GetUploadAnyFilesEvent extends UploadAnyFilesEvent {
  final List<File> files;

  GetUploadAnyFilesEvent(this.files);

  @override
  List<Object?> get props => [files];
}
