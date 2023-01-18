import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../settings.dart';

class SetUrlDropDownSection extends StatefulWidget {
  const SetUrlDropDownSection(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  final BaseUrlSchema value;
  final ValueChanged<String> onChanged;

  @override
  _SetUrlDropDownSectionState createState() => _SetUrlDropDownSectionState();
}

class _SetUrlDropDownSectionState extends State<SetUrlDropDownSection> {
  final _bloc = GetIt.I<UrlSettingBloc>();
  final ServerBloc _serverBloc = GetIt.I<ServerBloc>();
  final _urlCustomUrlController = TextEditingController();
  BaseUrlSchema _schema = BaseUrlSchema.https;

  @override
  void initState() {
    _urlCustomUrlController.addListener(() {
      _bloc.add(ChangeUrlSettingEvent(_urlCustomUrlController.text, _schema));
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
                  domain: _urlCustomUrlController.text, schema: _schema));
              widget.onChanged(_urlCustomUrlController.text);
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
                  endpoint: _urlCustomUrlController.text, schema: _schema));
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
                      controller: _urlCustomUrlController,
                      hintText: S.of(context).input_url,
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 241, 241),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: DropdownButton<BaseUrlSchema>(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: BaseUrlSchema.values
                              .map((value) => DropdownMenuItem(
                                    child: Text(value.toUrlSchema()),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              if (newValue != null) _schema = newValue;
                            });
                          },
                          value: _schema,
                          underline: const SizedBox(),
                          isExpanded: false,
                        ),
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
