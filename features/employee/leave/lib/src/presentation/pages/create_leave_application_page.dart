import 'dart:io';

import 'package:collection/collection.dart';
import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../leave.dart';
import '../blocs/blocs.dart';

class CreateLeaveApplicationPage extends StatefulWidget {
  final int maxRangeDays;
  const CreateLeaveApplicationPage({
    Key? key,
    required this.maxRangeDays,
  })  : assert(maxRangeDays > 0),
        super(key: key);
  @override
  _CreateLeaveApplicationPageState createState() =>
      _CreateLeaveApplicationPageState();
}

class _CreateLeaveApplicationPageState
    extends State<CreateLeaveApplicationPage> {
  final _leaveTypeBloc = GetIt.I<LeaveTypeBloc>();
  final _createLeaveBloc = GetIt.I<CreateLeaveBloc>();
  final TextEditingController _reasonController = TextEditingController();

  String? _leaveType;
  DateTime? _leaveFrom;
  DateTime? _leaveUntil;
  File? _file;

  final List<LeaveTypeEntity> _leaveTypeData = [];

  @override
  void initState() {
    _fetchLeaveType();
    super.initState();
  }

  void _fetchLeaveType() {
    _leaveTypeBloc.add(FetchLeaveTypeEvent(
      page: 1,
      perPage: 100,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _leaveTypeBloc,
        ),
        BlocProvider(
          create: (context) => _createLeaveBloc,
        ),
      ],
      child: BlocConsumer<LeaveTypeBloc, LeaveTypeState>(
        listener: (context, typeState) {
          if (typeState is LeaveTypeSuccess) {
            setState(() {
              _leaveTypeData.clear();
              _leaveTypeData.addAll(typeState.data);
            });
          }
        },
        builder: (context, typeState) {
          return BlocBuilder<CreateLeaveBloc, CreateLeaveState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(S.of(context).add_leave_application),
                ),
                body: BlocListener<CreateLeaveBloc, CreateLeaveState>(
                  listener: (context, state) {
                    if (state.status.isSubmissionFailure) {
                      IndicatorsUtils.showErrorSnackBar(
                          context, state.failure?.message);
                    } else if (state.status.isSubmissionInProgress) {
                      IndicatorsUtils.showLoadingSnackBar(context);
                    } else if (state.status.isSubmissionSuccess) {
                      Navigator.of(context).pop(true);
                      if (mounted) {
                        IndicatorsUtils.hideCurrentSnackBar();
                      }
                    }
                  },
                  child: _buildBody(typeState, state),
                ),
                bottomNavigationBar: _buildActionButton(typeState, state),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(LeaveTypeState typeState, CreateLeaveState createState) {
    if (typeState is LeaveTypeSuccess) {
      return _buildForm(createState);
    } else if (typeState is LeaveTypeFailure) {
      return _FailureContent(
        message: typeState.failure.message,
        onRefresh: _fetchLeaveType,
      );
    }
    return _LoadingContent();
  }

  Widget _buildForm(CreateLeaveState state) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimens.dp16),
        children: [
          AlertMessage.primary(
            RichText(
              text: TextSpan(
                text: '${S.of(context).remaining_leave_year_label}: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                children: [
                  TextSpan(
                    text: '${widget.maxRangeDays} ${S.of(context).days}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.dp16),
          DropdownInput(
            initialValue: _leaveType,
            isRequired: true,
            errorText:
                state.leaveType.valid ? null : S.of(context).required_input,
            onChange: _onTypeChanged,
            data: _leaveTypeData.map((e) => e.name).toList(),
            label: S.of(context).select_leave_type,
          ),
          const SizedBox(height: Dimens.dp16),
          DateInput(
            isRequired: true,
            label: S.of(context).leave_date_from,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 365)),
            value: _leaveFrom,
            onChange: _onLeaveFromChanged,
            errorText:
                state.dateFrom.valid ? null : S.of(context).required_input,
          ),
          const SizedBox(height: Dimens.dp16),
          DateInput(
            isRequired: true,
            label: S.of(context).leave_date_until,
            value: _leaveUntil,
            startDate: _leaveFrom ?? DateTime.now(),
            endDate: (_leaveFrom ?? DateTime.now())
                .add(Duration(days: widget.maxRangeDays - 1)),
            onChange: _onLeaveUntilChanged,
            errorText:
                state.dateUntil.valid ? null : S.of(context).required_input,
          ),
          const SizedBox(height: Dimens.dp16),
          TextAreaInput(
            isRequired: true,
            controller: _reasonController,
            label: S.of(context).reason,
            onChange: _onReasonChanged,
            errorText: state.reason.valid ? null : S.of(context).required_input,
          ),
          const SizedBox(height: Dimens.dp16),
          FileInput(
            label: S.of(context).upload_your_file,
            value: _file,
            allowExtension: const ['pdf', 'png', 'jpg', 'jpeg'],
            errorText: state.file.valid ? null : S.of(context).required_input,
            onChange: _onFileChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      LeaveTypeState typeState, CreateLeaveState createState) {
    if (typeState is LeaveTypeSuccess) {
      return SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(Dimens.dp16),
          child: PrimaryButton(
            onPressed: createState.status.isValidated ? _onSubmit : null,
            child: Text(S.of(context).add_leave_application),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _onTypeChanged(String type) {
    final _query =
        _leaveTypeData.firstWhereOrNull((element) => element.name == type);

    if (_query != null) {
      setState(() {
        _leaveType = type;
        _createLeaveBloc.add(CreateLeaveChangeType(_query.id));
      });
    }
  }

  void _onLeaveFromChanged(DateTime value) {
    if (_leaveUntil != null) {
      if (value.isAfter(_leaveUntil!)) {
        _leaveUntil = value;
        _createLeaveBloc.add(CreateLeaveChangeDateUntil(_leaveUntil!, value));
      } else if (value.isBefore(_leaveUntil!) &&
          value.difference(_leaveUntil!).inDays.abs() >= widget.maxRangeDays) {
        _leaveUntil = value;
        _createLeaveBloc.add(CreateLeaveChangeDateUntil(_leaveUntil!, value));
      }
    }
    setState(() {
      _leaveFrom = value;
      _createLeaveBloc.add(CreateLeaveChangeDateFrom(value));
    });
  }

  void _onLeaveUntilChanged(DateTime value) {
    if (_leaveFrom != null) {
      setState(() {
        _leaveUntil = value;
        _createLeaveBloc.add(CreateLeaveChangeDateUntil(value, _leaveFrom!));
      });
    }
  }

  void _onFileChanged(File v) {
    setState(() {
      _file = v;
    });
    _createLeaveBloc.add(CreateLeaveChangeFile(v));
  }

  void _onReasonChanged(String value) {
    _createLeaveBloc.add(CreateLeaveChangeReason(value));
  }

  void _onSubmit() {
    _createLeaveBloc.add(CreateLeaveSubmitted());
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
