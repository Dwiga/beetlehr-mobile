part of 'all_notice_board_bloc.dart';

abstract class AllNoticeBoardEvent extends Equatable {}

class FetchAllNoticeBoardEvent extends AllNoticeBoardEvent {
  final int page;
  final int perPage;
  FetchAllNoticeBoardEvent({
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [page, perPage];

  @override
  bool get stringify => true;
}
