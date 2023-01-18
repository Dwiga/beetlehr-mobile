import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../leave.dart';
import '../blocs/blocs.dart';
import '../component/component.dart';

class LeaveApplicationInProcessPage extends StatefulWidget {
  const LeaveApplicationInProcessPage({Key? key}) : super(key: key);

  @override
  _LeaveApplicationInProcessPageState createState() =>
      _LeaveApplicationInProcessPageState();
}

class _LeaveApplicationInProcessPageState
    extends State<LeaveApplicationInProcessPage>
    with AutomaticKeepAliveClientMixin<LeaveApplicationInProcessPage> {
  final ScrollController _scrollController = ScrollController();
  final LeaveInProcessBloc _bloc = GetIt.I<LeaveInProcessBloc>();

  bool isLoading = true;
  int _currentPage = 1;

  void _fetchData(int page) {
    _bloc.add(FetchLeaveInProcessEvent(page: page, perPage: 10));
  }

  @override
  void initState() {
    _fetchData(1);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        body: _buildBody(),
        floatingActionButton: _buildFloating(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LeaveInProcessBloc, LeaveInProcessState>(
      builder: (context, state) {
        if (state is LeaveInProcessSuccess) {
          _currentPage = state.page;
          return _SuccessContent(
            controller: _scrollController,
            data: state.data,
            quota: state.quota,
            isLoading: !state.hasReachedMax,
            onTapItem: (v) => _navigateToDetail(v.id),
          );
        } else if (state is LeaveInProcessFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: () => _fetchData(1),
          );
        }
        return _LoadingContent();
      },
    );
  }

  Widget _buildFloating() {
    return BlocBuilder<LeaveInProcessBloc, LeaveInProcessState>(
      builder: (context, state) {
        if (state is LeaveInProcessSuccess) {
          return FloatingActionButton(
              heroTag: 'leave_0',
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => _navigateToAdd(state.quota),
              child: const Icon(Icons.add, color: Colors.white));
        }
        return const SizedBox();
      },
    );
  }

  void _navigateToAdd(int quota) async {
    if (quota > 0) {
      final result = await Navigator.pushNamed(
        context,
        '/leave-application/add',
        arguments: {
          'max_range_days': quota,
        },
      );
      if (result == true) {
        _fetchData(1);
      }
    } else {
      IndicatorsUtils.showErrorSnackBar(
        context,
        S.of(context).message_leave_quota_is_empty,
      );
    }
  }

  void _navigateToDetail(int id) async {
    final result = await Navigator.of(context).pushNamed(
      '/leave-application/detail',
      arguments: {
        'id': id,
      },
    );

    if (result == true) {
      _fetchData(1);
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      _fetchData(_currentPage + 1);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class _SuccessContent extends StatelessWidget {
  final List<LeaveEntity> data;
  final int quota;
  final ScrollController? controller;
  final bool? isLoading;
  final ValueChanged<LeaveEntity> onTapItem;
  const _SuccessContent({
    Key? key,
    required this.data,
    required this.quota,
    this.controller,
    this.isLoading,
    required this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(S.of(context).leave_list_empty),
      );
    }
    return ListView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      children: [
        _buildBadge(context),
        _buildListCards(context),
        const SizedBox(height: Dimens.dp24),
        (isLoading ?? false) ? const LeaveItemSkeleton() : const SizedBox(),
      ],
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.dp16,
        0,
        Dimens.dp16,
        Dimens.dp16,
      ),
      child: AlertMessage.primary(
        RichText(
          text: TextSpan(
            text: '${S.of(context).remaining_leave_year_label}: ',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            children: [
              TextSpan(
                text: '$quota ${S.of(context).days}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCards(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return LeaveCardItem(
          data: data[i],
          onTap: () => onTapItem(data[i]),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: data.length,
    );
  }
}

class _FailureContent extends StatelessWidget {
  final String? message;
  final VoidCallback? onRefresh;

  const _FailureContent({Key? key, this.message, this.onRefresh})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ErrorMessageWidget(
        message: message,
        onPress: onRefresh,
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return const LeaveItemSkeleton();
      },
      itemCount: 16,
    );
  }
}
