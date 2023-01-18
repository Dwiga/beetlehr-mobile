import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';
import 'package:files/files.dart';

import '../../../resign.dart';
import '../blocs/blocs.dart';

class DetailResignPage extends StatefulWidget {
  final ResignEntity data;

  const DetailResignPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  _DetailResignPageState createState() => _DetailResignPageState();
}

class _DetailResignPageState extends State<DetailResignPage> {
  final _bloc = GetIt.I<CancelResignBloc>();
  final _downloadFileBloc = GetIt.I<DownloadFileBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _bloc,
        ),
        BlocProvider(
          create: (context) => _downloadFileBloc,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).resign_application),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<CancelResignBloc, CancelResignState>(
            listener: (context, state) {
          if (state is CancelResignLoading) {
            IndicatorsUtils.showLoadingSnackBar(context);
          } else if (state is CancelResignFailure) {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
            IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
          } else if (state is CancelResignSuccess) {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
            Navigator.of(context).pop(true);
          } else {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
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
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimens.dp16),
        children: [
          _buildStatus(),
          const SizedBox(height: Dimens.dp16),
          _buildDateProperty(),
          const SizedBox(height: Dimens.dp16),
          _buildReasonProperty(),
          const SizedBox(height: Dimens.dp16),
          _buildResignationTypeProperty(),
          if (widget.data.urlFile != null &&
              widget.data.urlFile!.isNotEmpty) ...[
            const SizedBox(height: Dimens.dp16),
            _buildFileProperty()
          ],
          const Divider(height: Dimens.dp16),
          _buildMessage(),
        ],
      ),
    );
  }

  Widget _buildStatus() {
    return Row(
      children: [
        Expanded(child: SubTitle1Text(widget.data.label)),
        const SizedBox(width: Dimens.dp16),
        _buildBadge(),
      ],
    );
  }

  Widget _buildBadge() {
    switch (widget.data.status) {
      case ResignStatus.waiting:
        return Badge.warning(text: 'AWAITING');
      case ResignStatus.approved:
        return Badge.success(text: 'APPROVED');
      case ResignStatus.rejected:
        return Badge.error(text: 'REJECTED');
      default:
        return const SizedBox();
    }
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
        SubTitle2Text(widget.data.date),
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

  Widget _buildResignationTypeProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle2Text(
          S.of(context).my_resignation_is,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: Dimens.dp8),
        SubTitle2Text(
          widget.data.isAccordingProcedure == true
              ? S.of(context).according_procedure_1
              : S.of(context).according_procedure_2,
        ),
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
            _downloadFileBloc.add(
              GetDownloadFileEvent(
                url: widget.data.urlFile!,
                fileName: widget.data.urlFile!.split('/').last,
                showNotification: true,
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
                  widget.data.urlFile?.split('/').last ?? '',
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

  Widget _buildMessage() {
    if (widget.data.status == ResignStatus.rejected) {
      return Container(
        padding: const EdgeInsets.all(Dimens.dp16),
        decoration: BoxDecoration(
          color: StaticColors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Dimens.dp8),
        ),
        child: const SubTitle2Text(
          'Pengajuan pengunduran diri '
          'Anda akan kami proses dalam 3 hari kerja. Terima kasih',
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildActionButton() {
    if (widget.data.status == ResignStatus.waiting) {
      return SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(Dimens.dp16),
          child: PrimaryButton(
            onPressed: _showDialog,
            color: StaticColors.red,
            child: Text(S.of(context).cancel),
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
        body: Text(S.of(context).question_confirm_cancel_resign),
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
              _bloc.add(GetCancelResignEvent(widget.data.id));
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
