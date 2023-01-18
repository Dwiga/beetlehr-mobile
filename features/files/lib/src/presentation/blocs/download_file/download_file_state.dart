part of 'download_file_bloc.dart';

abstract class DownloadFileState extends Equatable {}

class DownloadFileInitial extends DownloadFileState {
  @override
  List<Object?> get props => [];
}

class DownloadFileLoading extends DownloadFileState {
  @override
  List<Object?> get props => [];
}

class DownloadFileSuccess extends DownloadFileState {
  final String path;

  DownloadFileSuccess(this.path);

  @override
  List<Object?> get props => [path];
}

class DownloadFileFailure extends DownloadFileState {
  final Failure failure;

  DownloadFileFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
