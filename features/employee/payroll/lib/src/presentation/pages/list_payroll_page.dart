import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../payroll.dart';
import '../component/component.dart';

class ListPayrollPage extends StatefulWidget {
  final Map<String, int>? filterDate;
  const ListPayrollPage({
    Key? key,
    this.filterDate,
  }) : super(key: key);
  @override
  _ListPayrollPageState createState() => _ListPayrollPageState();
}

class _ListPayrollPageState extends State<ListPayrollPage>
    with AutomaticKeepAliveClientMixin<ListPayrollPage> {
  final ScrollController _scrollController = ScrollController();
  late PayrollBloc _bloc;

  bool isLoading = true;
  int _currentPage = 1;

  void _fetchData(int page) {
    if (widget.filterDate != null) {
      _bloc.add(FetchPayrollEvent(
          year: widget.filterDate?['year'],
          month: widget.filterDate?['month'],
          page: page,
          perPage: 15));
    } else {
      _bloc.add(FetchPayrollEvent(
        year: null,
        month: null,
        page: page,
        perPage: 15,
      ));
    }
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<PayrollBloc>(context);
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
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocBuilder<PayrollBloc, PayrollState>(
      builder: (context, state) {
        if (state is PayrollSuccess) {
          _currentPage = state.page;
          return _SuccessContent(
            controller: _scrollController,
            data: state.data,
            isLoading: !state.hasReachedMax,
          );
        } else if (state is PayrollFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: () => _fetchData(1),
          );
        }
        return _LoadingContent();
      },
    );
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
  final List<PayrollEntity> data;
  final ScrollController? controller;
  final bool? isLoading;

  const _SuccessContent({
    Key? key,
    required this.data,
    this.controller,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(S.of(context).payroll_list_empty),
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      padding: EdgeInsets.zero,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemBuilder: (_, i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/payroll-detail', arguments: {
                  'data': data[i],
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
                child: PayrollCard(
                  data: data[i],
                ),
              ),
            );
          },
          separatorBuilder: (_, i) {
            return const Divider(height: Dimens.dp24);
          },
          itemCount: data.length,
        ),
        const SizedBox(height: Dimens.dp24),
        (isLoading ?? false) ? const PayrollItemSkeleton() : const SizedBox(),
      ],
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
        return const PayrollItemSkeleton();
      },
      itemCount: 16,
    );
  }
}
