import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';
import 'package:files/files.dart';

import '../../../leave.dart';
import '../../utils/utils.dart';
import '../blocs/blocs.dart';

class LeaveApplicationDetailPage extends StatefulWidget {
  final int id;
  const LeaveApplicationDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _LeaveApplicationDetailPageState createState() =>
      _LeaveApplicationDetailPageState();
}

class _LeaveApplicationDetailPageState
    extends State<LeaveApplicationDetailPage> {
  final _bloc = GetIt.I<LeaveDetailBloc>();
  final _cancelBloc = GetIt.I<LeaveCancelBloc>();
  final _downloadFileBloc = GetIt.I<DownloadFileBloc>();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    _bloc.add(FetchLeaveDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _bloc,
        ),
        BlocProvider(
          create: (context) => _cancelBloc,
        ),
        BlocProvider(
          create: (context) => _downloadFileBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).detail),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
      builder: (context, state) {
        if (state is LeaveDetailSuccess) {
          return _SuccessContent(
            data: state.data,
            onCancel: () {
              _cancelBloc.add(GetLeaveCancelEvent(state.data.id));
            },
          );
        } else if (state is LeaveDetailFailure) {
          return _FailureContent(
            message: state.failure.message,
            onRefresh: _fetchData,
          );
        }
        return _LoadingContent();
      },
    );
  }
}

class _SuccessContent extends StatefulWidget {
  final LeaveDetailEntity data;
  final VoidCallback onCancel;
  const _SuccessContent({
    Key? key,
    required this.data,
    required this.onCancel,
  }) : super(key: key);

  @override
  __SuccessContentState createState() => __SuccessContentState();
}

class __SuccessContentState extends State<_SuccessContent> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LeaveCancelBloc, LeaveCancelState>(
            listener: (context, state) {
          if (state is LeaveCancelFailure) {
            IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
          } else if (state is LeaveCancelLoading) {
            IndicatorsUtils.showLoadingSnackBar(context);
          } else if (state is LeaveCancelSuccess) {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
            Navigator.of(context).pop(true);
          }
        }),
        BlocListener<DownloadFileBloc, DownloadFileState>(
            listener: (context, state) {
          if (state is DownloadFileLoading) {
            IndicatorsUtils.showMessageSnackbar(
                context, S.of(context).start_downloading_file);
          }
        }),
      ],
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(Dimens.dp16),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildStatus(),
              const SizedBox(height: Dimens.dp16),
              _buildTypeProperty(),
              const SizedBox(height: Dimens.dp16),
              _buildDateProperty(),
              const SizedBox(height: Dimens.dp16),
              if (widget.data.fileUrl != null &&
                  widget.data.fileUrl!.isNotEmpty) ...[
                _buildFileProperty(),
                const SizedBox(height: Dimens.dp16)
              ],
              _buildReasonProperty(),
              const Divider(
                height: Dimens.dp32,
              ),
              _buildMessage(),
            ],
          ),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    return Row(
      children: [
        Expanded(child: SubTitle1Text(widget.data.label)),
        const SizedBox(width: Dimens.dp16),
        LeaveUtils.getLeaveBadge(widget.data.status),
      ],
    );
  }

  Widget _buildTypeProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(
          S.of(context).type,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: Dimens.dp8),
        SubTitle2Text(widget.data.leaveType),
      ],
    );
  }

  Widget _buildFileProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(
          'File',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: Dimens.dp8),
        InkWell(
          onTap: () {
            BlocProvider.of<DownloadFileBloc>(context).add(
              GetDownloadFileEvent(
                url: widget.data.fileUrl!,
                fileName: widget.data.fileUrl!.split('/').last,
                withHttpClient: Platform.isIOS,
              ),
            );
          },
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Dimens.width(context) * 0.7,
                ),
                child: SubTitle2Text(
                  widget.data.fileUrl?.split('/').last ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: Dimens.dp8),
              Icon(
                Icons.file_download,
                size: Dimens.dp24,
                color: Theme.of(context).primaryColorLight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(
          S.of(context).date,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: Dimens.dp8),
        Row(
          children: [
            SubTitle2Text('${widget.data.startDate}  •  '),
            RegularText(widget.data.totalDate?.toString() ?? ''),
            RegularText(' ${S.of(context).days}')
          ],
        ),
      ],
    );
  }

  Widget _buildReasonProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(
          S.of(context).reason,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: Dimens.dp8),
        SubTitle2Text(
          widget.data.reason ?? '',
        ),
      ],
    );
  }

  Widget _buildMessage() {
    if (widget.data.status != LeaveStatus.approved &&
        widget.data.rejectReason != null) {
      return Container(
        padding: const EdgeInsets.all(Dimens.dp16),
        decoration: BoxDecoration(
          color: (widget.data.status.getColor() ?? Colors.transparent)
              .withOpacity(0.2),
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
        child: SubTitle2Text(
          widget.data.rejectReason ?? '',
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildActionButton() {
    if (widget.data.status == LeaveStatus.waiting) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: SafeArea(
          child: Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(Dimens.dp16),
            child: PrimaryButton(
              onPressed: _showDialog,
              color: StaticColors.red,
              child: Text(S.of(context).cancel),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        body: Text(S.of(context).question_confirm_cancel_leave),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).no),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onCancel();
            },
            child: Text(S.of(context).yes),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}

class _LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Skeleton(height: Dimens.dp40, width: null),
          SizedBox(height: Dimens.dp16),
          Skeleton(height: Dimens.dp40, width: null),
          SizedBox(height: Dimens.dp16),
          Skeleton(height: Dimens.dp40, width: null),
          SizedBox(height: Dimens.dp16),
          Skeleton(height: Dimens.dp40, width: null),
          SizedBox(height: Dimens.dp16),
        ],
      ),
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
