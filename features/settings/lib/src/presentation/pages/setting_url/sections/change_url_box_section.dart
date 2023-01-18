import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../settings.dart';

class ChangeUrlBoxSection extends StatefulWidget {
  const ChangeUrlBoxSection({Key? key, required this.onChanged})
      : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  _ChangeUrlBoxSectionState createState() => _ChangeUrlBoxSectionState();
}

class _ChangeUrlBoxSectionState extends State<ChangeUrlBoxSection> {
  final _bloc = GetIt.I<UrlSettingBloc>();
  final ServerBloc _serverBloc = GetIt.I<ServerBloc>();
  final _urlCloudController = TextEditingController();

  @override
  void initState() {
    _urlCloudController.addListener(() {
      _bloc.add(ChangeUrlSettingEvent(
          _urlCloudController.text.isNotEmpty
              ? _urlCloudController.text + ".qerja.io"
              : _urlCloudController.text,
          BaseUrlSchema.https));
    });
    super.initState();
  }

  void _refreshSetting() async {
    final settingConfig = (await GetIt.I<GetBaseUrlUseCase>().call(NoParams()))
        .foldRight(null, (r, previous) => r);

    if (settingConfig != null) {
      GetIt.I<Dio>().options.baseUrl = settingConfig.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _serverBloc,
        ),
      ],
      child: BlocListener<ServerBloc, CheckServerState>(
        listener: (context, state) {
          if (state is CheckServerLoading) {
            IndicatorsUtils.showLoadingSnackBar(context);
          } else if (state is CheckServerFailure) {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
            IndicatorsUtils.showErrorSnackBar(
                context, S.of(context).make_sure_the_domain_and_connection);
            GetIt.I<DeleteBaseUrlUseCase>().call(NoParams());
          } else if (state is CheckServerSuccess) {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
              Navigator.of(context).maybePop(true);
              GetIt.I<SetBaseUrlUseCase>().call(SetBaseUrlParams(
                  domain: _urlCloudController.text + ".qerja.io",
                  schema: BaseUrlSchema.https));
              widget.onChanged(_urlCloudController.text + ".qerja.io");
            }
          } else {
            if (mounted) {
              IndicatorsUtils.hideCurrentSnackBar();
            }
            IndicatorsUtils.showErrorSnackBar(
                context, S.of(context).make_sure_the_domain_and_connection);
            GetIt.I<DeleteBaseUrlUseCase>().call(NoParams());
          }
        },
        child: BlocConsumer<UrlSettingBloc, UrlSettingState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              IndicatorsUtils.showErrorSnackBar(
                  context, state.failure?.message);
            } else if (state.status.isSubmissionSuccess) {
              _refreshSetting();
              _serverBloc.add(FetchCheckServerEvent(
                  endpoint: _urlCloudController.text.isNotEmpty
                      ? _urlCloudController.text + ".qerja.io"
                      : _urlCloudController.text,
                  schema: BaseUrlSchema.https));
            }
          },
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Dimens.dp16, horizontal: Dimens.dp16),
              child: Center(
                child: Column(children: [
                  Expanded(
                    child: RegularTextInput(
                      hintText: S.of(context).input_url,
                      controller: _urlCloudController,
                      suffix: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 48,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 241, 241),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: const Text("qerja.io"),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: PrimaryButton(
                      onPressed: state.status.isValidated &&
                              !state.status.isSubmissionInProgress
                          ? () {
                              _bloc.add(UrlSettingSubmittedEvent());
                            }
                          : null,
                      child: Text(S.of(context).connect),
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
