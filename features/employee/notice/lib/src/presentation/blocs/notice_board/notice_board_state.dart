part of 'notice_board_bloc.dart';

abstract class NoticeBoardState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoticeBoardLoading extends NoticeBoardState {}

class NoticeBoardFailure extends NoticeBoardState {
  final Failure failure;

  NoticeBoardFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class NoticeBoardSuccess extends NoticeBoardState {
  final List<NoticeEntity> data;
  NoticeBoardSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}
