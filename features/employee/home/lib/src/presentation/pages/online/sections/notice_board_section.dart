import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/notice.dart';
import 'package:preferences/preferences.dart';

class NoticeBoardSection extends StatefulWidget {
  const NoticeBoardSection({Key? key}) : super(key: key);

  @override
  _NoticeBoardSectionState createState() => _NoticeBoardSectionState();
}

class _NoticeBoardSectionState extends State<NoticeBoardSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoticeBoardBloc, NoticeBoardState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SubTitle1Text(
                    S.of(context).notice_board,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildAction(state),
              ],
            ),
            _buildContent(state),
          ],
        );
      },
    );
  }

  Widget _buildAction(NoticeBoardState state) {
    if (state is NoticeBoardSuccess) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/all-notice-board');
        },
        child: RegularText(
          S.of(context).view_all,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      );
    } else if (state is NoticeBoardFailure) {
      return InkWell(
        onTap: () {
          BlocProvider.of<NoticeBoardBloc>(context).add(FetchNoticeBoardEvent(
            page: 1,
            perPage: 10,
            refresh: true,
          ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              size: Dimens.dp16,
              color: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(width: Dimens.dp4),
            RegularText(
              S.of(context).reload,
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildContent(NoticeBoardState state) {
    if (state is NoticeBoardSuccess) {
      return _buildListBoard(state.data);
    }
    return _ContentLoading();
  }

  Widget _buildListBoard(List<NoticeEntity> data) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemBuilder: (_, i) {
        return NoticeItemCard(
          date: data[i].date,
          title: data[i].title,
          onTap: () {
            Navigator.of(context).pushNamed('/detail-notice', arguments: {
              'notice': data[i],
            });
          },
        );
      },
      itemCount: data.length,
      separatorBuilder: (_, __) {
        return const Divider(height: 1);
      },
    );
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
        return _buildItemLoading(context);
      },
      itemCount: 3,
      separatorBuilder: (_, __) {
        return const Divider(height: 1);
      },
    );
  }

  Widget _buildItemLoading(BuildContext context) {
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
