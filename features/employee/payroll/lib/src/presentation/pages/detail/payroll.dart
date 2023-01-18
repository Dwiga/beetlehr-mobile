import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../payroll.dart';
import '../../../helper/print_pdf.dart';
import '../../component/component.dart';
import 'sections/sections.dart';

class PayrollDetailPage extends StatefulWidget {
  final PayrollEntity data;
  const PayrollDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  _PayrollDetailPageState createState() => _PayrollDetailPageState();
}

class _PayrollDetailPageState extends State<PayrollDetailPage> {
  final _bloc = GetIt.I<PayrollDetailBloc>();

  @override
  void initState() {
    _bloc.add(FetchPayrollDetailEvent(id: widget.data.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PayrollDetailBloc, PayrollDetailState>(
      builder: (context, state) {
        if (state is PayrollDetailSuccess) {
          return _SuccessContent(
            data: state.data,
            date: widget.data.date ?? DateTime.now(),
          );
        } else if (state is PayrollDetailFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: () {
              _bloc.add(FetchPayrollDetailEvent(id: widget.data.id));
            },
          );
        }
        return _LoadingContent(
          date: widget.data.date ?? DateTime.now(),
        );
      },
    );
  }
}

class _SuccessContent extends StatefulWidget {
  final PayrollDetailEntity data;
  final DateTime date;
  const _SuccessContent({
    Key? key,
    required this.data,
    required this.date,
  }) : super(key: key);
  @override
  __SuccessContentState createState() => __SuccessContentState();
}

class __SuccessContentState extends State<_SuccessContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text('Salary Slip '
                '${DateFormat('MMMM').format(widget.date)}'),
            pinned: true,
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.save_alt,
                  ),
                  onPressed: () {
                    PayrollHelper(widget.data).print();
                  }),
            ],
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderSection(data: widget.data),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                EarningSection(data: widget.data),
                Container(
                  height: Dimens.dp24,
                  width: double.infinity,
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                ),
                DeductionSection(data: widget.data),
                ResignPinaltySection(data: widget.data),
                const SizedBox(height: Dimens.dp24),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildTotal(),
    );
  }

  Widget _buildTotal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: StaticColors.green,
          padding: const EdgeInsets.all(Dimens.dp16),
          child: SafeArea(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Take Home Pay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SubTitle1Text(
                  Utils.rupiahFormatter(_getTakeHomePay()) ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _getTakeHomePay() {
    if (widget.data.totalAmountAfterPinalty != null) {
      return widget.data.totalAmountAfterPinalty ?? 0;
    }
    return widget.data.totalAmount;
  }
}

class _LoadingContent extends StatelessWidget {
  final DateTime date;
  const _LoadingContent({
    Key? key,
    required this.date,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AppBar(
          title: Text('Salary Slip '
              '${DateFormat('MMMM').format(date)}'),
        ),
        const Skeleton(
          height: 150,
          width: double.infinity,
          radius: 0,
        ),
        const SizedBox(height: Dimens.dp32),
        const PayrollItemSkeleton(),
        const SizedBox(height: Dimens.dp12),
        const PayrollItemSkeleton(),
        const PayrollItemSkeleton(),
        const SizedBox(height: Dimens.dp12),
        const PayrollItemSkeleton(),
        const PayrollItemSkeleton(),
        const SizedBox(height: Dimens.dp12),
        const PayrollItemSkeleton(),
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
