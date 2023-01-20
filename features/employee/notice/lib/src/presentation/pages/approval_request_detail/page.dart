import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:notice/src/presentation/pages/approval_request_detail/section/sections.dart';
import 'package:preferences/preferences.dart';

import '../../../../notice.dart';

class ApprovalRequestDetailPage extends StatefulWidget {
  final int id;
  final String type;

  const ApprovalRequestDetailPage(
      {Key? key, required this.id, required this.type})
      : super(key: key);
  @override
  _ApprovalRequestDetailPageState createState() =>
      _ApprovalRequestDetailPageState();
}

class _ApprovalRequestDetailPageState extends State<ApprovalRequestDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final _approvalRequestDetailBloc = GetIt.I<ApprovalRequestDetailBloc>();
  final _approveRequestBloc = GetIt.I<ApproveRequestBloc>();
  final _rejectRequestBloc = GetIt.I<RejectRequestBloc>();
  bool statusUpdeted = false;

  @override
  void initState() {
    _fetchApprovalRequestDetail();
    super.initState();
  }

  void _fetchApprovalRequestDetail() {
    _approvalRequestDetailBloc.add(
      FetchApprovalRequestDetailEvent(widget.id, widget.type),
    );
  }

  void _approveRequest(String? reason) {
    _approveRequestBloc.add(
      FetchApproveRequestEvent(
        id: widget.id,
        body: ApproverRequestBodyModel(reason: reason, type: widget.type),
      ),
    );
  }

  void _rejectRequest(String? reason) {
    _rejectRequestBloc.add(
      FetchRejectRequestEvent(
        id: widget.id,
        body: ApproverRequestBodyModel(reason: reason, type: widget.type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(statusUpdeted);
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _approvalRequestDetailBloc,
          ),
          BlocProvider(
            create: (_) => _approveRequestBloc,
          ),
          BlocProvider(
            create: (_) => _rejectRequestBloc,
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              S.of(context).approval_request_details,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: _buildBody(context),
          bottomNavigationBar: _buildActionButton(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<ApprovalRequestDetailBloc, ApprovalRequestDetailState>(
        builder: (context, state) {
          if (state is ApprovalRequestDetailSuccess) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(Dimens.dp16),
              children: [
                HeaderInformationSection(data: state.data),
                const SizedBox(height: Dimens.dp16),
                RequestDetailInformationSection(data: state.data),
                const SizedBox(height: Dimens.dp16),
                // Sementara dihidden dulu
                // TimeLineSection(data: state.data),
              ],
            );
          }

          return const LoadingContent();
        },
      ),
    );
  }

  void _showDialog(Color color, String textButton, String? icon) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SingleChildScrollView(
          child: SizedBox(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimens.dp16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.dp24),
                  child: Image.asset(
                    'assets/images/$icon',
                    width: Dimens.width(context) * 0.6,
                    height: 60,
                  ),
                ),
                const SizedBox(height: Dimens.dp16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
                  child: Center(
                    child: Text(
                      textButton == S.of(context).approve
                          ? S.of(context).approve_status_request
                          : S.of(context).reject_status_request,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.dp16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
                  child: TextAreaInput(
                    isRequired: textButton == S.of(context).reject,
                    controller: _controller,
                    minLine: 6,
                    label: S.of(context).note,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: const Divider(
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dp10),
        ),
        contentTextStyle: Theme.of(context).textTheme.bodyText2,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.dp8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.dp14, horizontal: Dimens.dp32),
                      child: Text(
                        S.of(context).cancel,
                        style: const TextStyle(
                            fontSize: Dimens.dp12, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.dp8),
                Expanded(
                  child: PrimaryButton(
                    color: color,
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                        if (textButton == S.of(context).approve) {
                          _approveRequest(_controller.text);
                        } else {
                          _rejectRequest(_controller.text);
                        }
                      });
                    },
                    child: Text(
                      textButton,
                      style: const TextStyle(
                        fontSize: Dimens.dp12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildActionButton() {
    return MultiBlocListener(
      listeners: [
        BlocListener<ApproveRequestBloc, ApproveRequestState>(
          listener: (context, state) {
            if (state is ApproveRequestLoading) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state is ApproveRequestFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is ApproveRequestSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
                _fetchApprovalRequestDetail();
                IndicatorsUtils.showSuccessSnackbar(
                    context, S.of(context).approval_request_approved_message);
              }
              statusUpdeted = true;
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          },
        ),
        BlocListener<RejectRequestBloc, RejectRequestState>(
          listener: (context, state) {
            if (state is RejectRequestLoading) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state is RejectRequestFailure) {
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is RejectRequestSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
                _fetchApprovalRequestDetail();
                IndicatorsUtils.showSuccessSnackbar(
                    context, S.of(context).approval_request_rejected_message);
              }
              statusUpdeted = true;
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          },
        ),
      ],
      child: BlocBuilder<ApprovalRequestDetailBloc, ApprovalRequestDetailState>(
        builder: (context, state) {
          if (state is ApprovalRequestDetailSuccess) {
            return state.data.isApprovable
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.dp16, vertical: Dimens.dp16),
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(145, 241, 241, 241),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PrimaryButton(
                            onPressed: () {
                              _showDialog(Theme.of(context).primaryColor,
                                  S.of(context).approve, "approve_dialog.png");
                            },
                            child: Text(S.of(context).approve),
                          ),
                        ),
                        const SizedBox(height: Dimens.dp8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Dimens.dp8),
                              ),
                            ),
                            onPressed: () {
                              _showDialog(Colors.red, S.of(context).reject,
                                  "reject_dialog.png");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimens.dp14,
                                  horizontal: Dimens.dp32),
                              child: Text(S.of(context).reject),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
          }
          return const LoadingContent();
        },
      ),
    );
  }
}
