part of 'notice_board_bloc.dart';

abstract class NoticeBoardEvent extends Equatable {}

class FetchNoticeBoardEvent extends NoticeBoardEvent {
  final int page;
  final int perPage;
  final bool refresh;
  FetchNoticeBoardEvent({
    required this.page,
    required this.perPage,
    this.refresh = false,
  });

  @override
  List<Object> get props => [page, perPage, refresh];

  @override
  bool get stringify => true;
}
