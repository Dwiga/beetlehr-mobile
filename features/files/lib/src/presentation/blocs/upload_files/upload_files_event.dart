part of 'upload_files_bloc.dart';

abstract class UploadFilesEvent extends Equatable {}

class GetUploadFilesEvent extends UploadFilesEvent {
  final List<File> files;

  GetUploadFilesEvent(this.files);

  @override
  List<Object?> get props => [files];
}
