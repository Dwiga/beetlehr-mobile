import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../../../notice.dart';
import 'all_approval_item_skeleton_section.dart';
import 'content_loading_section.dart';

class WaitingListApprovalPage extends StatefulWidget {
  final ApprovalRequestType? statusLabel;
  final String? sortBy;
  final String? startTime;
  final String? endTime;

  const WaitingListApprovalPage({
    Key? key,
    this.statusLabel,
    this.sortBy,
    this.endTime,
    this.startTime,
  }) : super(key: key);

  @override
  State<WaitingListApprovalPage> createState() =>
      _WaitingListApprovalPageState();
}

class _WaitingListApprovalPageState extends State<WaitingListApprovalPage> {
  late AllAppprovalRequestBloc _bloc;
  bool isSelected = true;
  VoidCallback? onTap;

  final _scrollController = ScrollController();

  int _currentPage = 1;

  @override
  void initState() {
    _bloc = GetIt.I<AllAppprovalRequestBloc>();
    fetchData(1);

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WaitingListApprovalPage oldWidget) {
    if (widget.sortBy != oldWidget.sortBy ||
        widget.startTime != oldWidget.startTime ||
        widget.endTime != oldWidget.endTime) {
      fetchData(1);
    }
    super.didUpdateWidget(oldWidget);
  }

  void fetchData(int page) {
    _bloc.add(
      FetchAllApprovalRequestEvent(
          page: page,
          perPage: 10,
          sortBy: widget.sortBy ?? "asc",
          startTime: widget.startTime,
          endTime: widget.endTime,
          status: widget.statusLabel),
    );
  }

  void _onScroll() {
    if (_isBottom) fetchData(_currentPage + 1);
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AllAppprovalRequestBloc, AllApprovalRequestState>(
          builder: (context, state) {
            if (state is AllApprovalRequestSuccess) {
              _currentPage = state.page;
              return _buildListApproval(
                state.data,
                hasReachedMax: state.hasReachedMax,
              );
            } else if (state is AllApprovalRequestFailure) {
              return Center(
                child: ErrorMessageWidget(
                  message: state.failure.message,
                  onPress: () => fetchData(1),
                ),
              );
            }
            return const ContentLoading();
          },
        ),
      ),
    );
  }

  Widget _buildListApproval(List<ApprovalRequestEntity> data,
      {required bool hasReachedMax}) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          S.of(context).no_data_approval_request,
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            return InkWell(
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(
                    '/detail-approval-request',
                    arguments: {'id': data[i].id, 'type': data[i].type});

                if (result == true) {
                  fetchData(1);
                }
              },
              child: TimeOffApprovalRequestCard(
                imageUrl: data[i].requestImage,
                name: data[i].requestName,
                cratedAt:
                    Utils.timeAgoSinceDate(createdTime: data[i].requestedAt)
                        .toString(),
                status: data[i].status,
                statusLabel: data[i].statusLabel,
                type: data[i].type,
                typeLabel: data[i].typeLabel,
                startTime: data[i].metaData?.startTime != null
                    ? formateDate(data[i].metaData!.startTime.toString())
                    : "",
                endTime: data[i].metaData?.endTime != null
                    ? formateDate(data[i].metaData!.endTime.toString())
                    : "",
                duration:
                    "${data[i].metaData?.duration != null ? data[i].metaData!.duration : 0} Days",
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
          const AllApprovalItemSkeleton(),
        ],
      ],
    );
  }

  String formateDate(String dateTime) {
    var inputFormat = DateFormat('y-MM-dd');
    var inputDate = inputFormat.parse(dateTime.toString());
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}
