import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../notice.dart';

class AllNoticeBoardPage extends StatefulWidget {
  const AllNoticeBoardPage({Key? key}) : super(key: key);

  @override
  _AllNoticeBoardPageState createState() => _AllNoticeBoardPageState();
}

class _AllNoticeBoardPageState extends State<AllNoticeBoardPage> {
  late AllNoticeBoardBloc _bloc;
  final _scrollController = ScrollController();

  int _currentPage = 1;

  @override
  void initState() {
    _bloc = GetIt.I<AllNoticeBoardBloc>();
    _fetchData(1);

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _fetchData(int page) {
    _bloc.add(FetchAllNoticeBoardEvent(page: page, perPage: 10));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).notice_board),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
          child: BlocBuilder<AllNoticeBoardBloc, AllNoticeBoardState>(
            builder: (context, state) {
              if (state is AllNoticeBoardSuccess) {
                _currentPage = state.page;
                return _buildListNotice(
                  state.data,
                  hasReachedMax: state.hasReachedMax,
                );
              } else if (state is AllNoticeBoardFailure) {
                return ErrorMessageWidget(
                  message: state.failure.message,
                  onPress: () => _fetchData(1),
                );
              }
              return _ContentLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListNotice(List<NoticeEntity> data,
      {required bool hasReachedMax}) {
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (_, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/detail-notice', arguments: {
                  'notice': data[i],
                });
              },
              child: NoticeItemCard(
                date: data[i].date,
                title: data[i].title,
              ),
            );
          },
          itemCount: data.length,
          separatorBuilder: (_, __) {
            return const Divider(height: 1);
          },
        ),
        if (!hasReachedMax) ...[
          const Divider(height: 1),
          const _NoticeBoardItemSkeleton(),
        ],
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) _fetchData(_currentPage + 1);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _ContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemBuilder: (_, __) {
        return const _NoticeBoardItemSkeleton();
      },
      itemCount: 3,
      separatorBuilder: (_, __) {
        return const Divider(height: 1);
      },
    );
  }
}

class _NoticeBoardItemSkeleton extends StatelessWidget {
  const _NoticeBoardItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Container(
        height: Dimens.dp16,
        padding: EdgeInsets.only(right: Dimens.width(context) * .1),
        child: const Skeleton(),
      ),
      subtitle: Container(
        height: Dimens.dp14,
        padding: EdgeInsets.only(right: Dimens.width(context) * .4),
        child: const Skeleton(),
      ),
      trailing: const Skeleton(
        height: Dimens.dp24,
        width: Dimens.dp24,
      ),
    );
  }
}
