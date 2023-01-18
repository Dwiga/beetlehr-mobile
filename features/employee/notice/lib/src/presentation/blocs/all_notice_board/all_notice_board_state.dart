part of 'all_notice_board_bloc.dart';

abstract class AllNoticeBoardState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllNoticeBoardLoading extends AllNoticeBoardState {}

class AllNoticeBoardFailure extends AllNoticeBoardState {
  final Failure failure;
  AllNoticeBoardFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class AllNoticeBoardSuccess extends AllNoticeBoardState {
  final List<NoticeEntity> data;
  final bool hasReachedMax;
  final int page;

  AllNoticeBoardSuccess({
    required this.data,
    required this.hasReachedMax,
    required this.page,
  });

  @override
  List<Object> get props => [data, hasReachedMax, page];
}
