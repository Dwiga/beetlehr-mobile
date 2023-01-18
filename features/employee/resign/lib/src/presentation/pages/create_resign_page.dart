import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../blocs/blocs.dart';

class CreateResignPage extends StatefulWidget {
  const CreateResignPage({Key? key}) : super(key: key);

  @override
  _CreateResignPageState createState() => _CreateResignPageState();
}

class _CreateResignPageState extends State<CreateResignPage> {
  final _bloc = GetIt.I<CreateResignBloc>();

  DateTime? _date;
  DateTime? _endContractDate;
  int? _radioValue;
  File? _file;
  bool _showEndContract = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).create_resign_application),
        ),
        body: _buildBody(),
        persistentFooterButtons: [
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<CreateResignBloc, CreateResignState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          IndicatorsUtils.showErrorSnackBar(context, state.failure?.message);
        } else if (state.status.isSubmissionInProgress) {
          IndicatorsUtils.showLoadingSnackBar(context);
        } else if (state.status.isSubmissionSuccess) {
          if (mounted) {
            IndicatorsUtils.hideCurrentSnackBar();
          }
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimens.dp16),
          children: [
            _buildSubmitDate(state),
            const SizedBox(height: Dimens.dp16),
            _buildEndContract(state),
            _buildReason(state),
            const SizedBox(height: Dimens.dp16),
            _buildResignationType(state),
            const SizedBox(height: Dimens.dp16),
            _buildFile(state),
            const SizedBox(height: Dimens.dp16),
            SubTitle1Text(
              S.of(context).message_create_resign_application,
              style: const TextStyle(
                fontSize: Dimens.dp12,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubmitDate(CreateResignState state) {
    return DateInput(
      isRequired: true,
      label: S.of(context).resign_date,
      value: _date,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)),
      errorText: state.submitDate.valid ? null : S.of(context).required_input,
      onChange: (v) {
        setState(() {
          _date = v;
          if (_radioValue == 1) {
            _endContractDate = v.add(const Duration(days: 30));
            _bloc.add(CreateResignChangeContractDate(_endContractDate!));
          } else if (_endContractDate != null) {
            _formatEndContractDate(v);

            _bloc.add(CreateResignChangeContractDate(_endContractDate!));
          }
        });
        _bloc.add(CreateResignChangeSubmitDate(_date!));
      },
    );
  }

  Widget _buildResignationType(CreateResignState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          label: S.of(context).my_resignation_is,
          isRequired: true,
        ),
        const SizedBox(height: Dimens.dp8),
        RadioListTile(
          value: 1,
          activeColor: Theme.of(context).primaryColorLight,
          groupValue: _radioValue,
          onChanged: (v) {
            if (v is int) {
              setState(() {
                _radioValue = v;
                _showEndContract = true;
                if (_date != null) {
                  _endContractDate = _date!.add(const Duration(days: 30));
                } else {
                  _endContractDate =
                      DateTime.now().add(const Duration(days: 30));
                }
                _bloc.add(CreateResignChangeContractDate(_endContractDate!));
              });
              _bloc.add(CreateResignChangeResignType(v));
            }
          },
          title: Text(S.of(context).according_procedure_1),
        ),
        RadioListTile(
          value: 0,
          groupValue: _radioValue,
          activeColor: Theme.of(context).primaryColorLight,
          onChanged: (v) {
            if (v is int) {
              setState(() {
                _radioValue = v;
                _showEndContract = true;
                if (_date != null) {
                  _formatEndContractDate(_date!);
                  _bloc.add(CreateResignChangeContractDate(_endContractDate!));
                }
              });

              _bloc.add(CreateResignChangeResignType(v));
            }
          },
          title: Text(S.of(context).according_procedure_2),
        ),
        state.resignType.valid
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(top: Dimens.dp6),
                child: Text(
                  S.of(context).required_input,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: Dimens.dp12,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildEndContract(CreateResignState state) {
    if (_showEndContract == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateInput(
            isRequired: true,
            label: S.of(context).end_contract,
            value: _endContractDate,
            startDate: _date != null ? _date! : DateTime.now(),
            endDate: (_radioValue == 0 && _date != null)
                ? _date!.add(const Duration(days: 29))
                : DateTime.now().add(const Duration(days: 335)),
            readOnly: (_radioValue == 1),
            errorText: state.endContractDate.valid
                ? null
                : S.of(context).required_input,
            onChange: (v) {
              setState(() {
                _endContractDate = v;
              });
              _bloc.add(CreateResignChangeContractDate(v));
            },
          ),
          const SizedBox(height: Dimens.dp16),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildReason(CreateResignState state) {
    return TextAreaInput(
      isRequired: true,
      label: S.of(context).reason,
      errorText: state.reason.valid ? null : S.of(context).required_input,
      onChange: (v) {
        _bloc.add(CreateResignChangeReason(v));
      },
    );
  }

  Widget _buildFile(CreateResignState state) {
    return FileInput(
      label: S.of(context).upload_your_file,
      value: _file,
      allowExtension: const ['pdf', 'png', 'jpg', 'jpeg'],
      errorText: state.file.valid ? null : S.of(context).required_input,
      onChange: (v) {
        setState(() {
          _file = v;
        });
        _bloc.add(CreateResignChangeFile(v));
      },
    );
  }

  Widget _buildActionButton() {
    return BlocBuilder<CreateResignBloc, CreateResignState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.dp8),
              child: PrimaryButton(
                child: Text(S.of(context).create),
                onPressed: state.status.isValidated &&
                        !state.status.isSubmissionInProgress
                    ? () {
                        _bloc.add(CreateResignSubmitted());
                        FocusScope.of(context).unfocus();
                      }
                    : null,
              )),
        );
      },
    );
  }

  void _formatEndContractDate(DateTime date) {
    if (_date != null && _endContractDate != null) {
      if (_date!.isBefore(_endContractDate!)) {
        if (_date!.difference(_endContractDate!).inDays.abs() >= 30) {
          _endContractDate = date.add(const Duration(days: 29));
        }
      } else {
        _endContractDate = date.add(const Duration(days: 1));
      }
    }
  }

  @override
  void dispose() {
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}
