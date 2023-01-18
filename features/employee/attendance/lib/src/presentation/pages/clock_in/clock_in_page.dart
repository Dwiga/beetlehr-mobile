import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../../attendance.dart';
import '../clock_page.dart';

class ClockInPage extends StatefulWidget {
  final ClockAcceptModel data;
  final ClockBodyModel clockBody;

  const ClockInPage({Key? key, required this.data, required this.clockBody})
      : super(key: key);

  @override
  _ClockInPageState createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {
  final TextEditingController _noteController = TextEditingController();
  final AttendanceBloc _attendanceBloc = GetIt.I<AttendanceBloc>();
  final UploadFilesBloc _uploadFilesBloc = GetIt.I<UploadFilesBloc>();

  List<File> _files = [];

  @override
  void dispose() {
    _noteController.dispose();
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _attendanceBloc,
        ),
        BlocProvider(
          create: (context) => _uploadFilesBloc,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(S.of(context).clock_in),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AttendanceBloc, AttendanceState>(
                listener: (context, state) {
              if (state is AttendanceLoading) {
                IndicatorsUtils.showLoadingSnackBar(context);
              } else if (state is AttendanceFailure) {
                if (state.failure.code == 409) {
                  _onSuccess();
                } else {
                  if (mounted) {
                    IndicatorsUtils.hideCurrentSnackBar();
                  }
                  IndicatorsUtils.showErrorSnackBar(
                      context, state.failure.message);
                }
              } else if (state is AttendanceSuccess) {
                _onSuccess(trackerConfig: state.data);
              } else {
                if (mounted) {
                  IndicatorsUtils.hideCurrentSnackBar();
                }
              }
            }),
            BlocListener<UploadFilesBloc, UploadFilesState>(
              listener: (context, state) {
                if (state is UploadFilesLoading) {
                  IndicatorsUtils.showLoadingSnackBar(context);
                } else if (state is UploadFilesFailure) {
                  if (mounted) {
                    IndicatorsUtils.hideCurrentSnackBar();
                  }
                  IndicatorsUtils.showErrorSnackBar(
                      context, state.failure.message);
                } else if (state is UploadFilesSuccess) {
                  if (mounted) {
                    IndicatorsUtils.hideCurrentSnackBar();
                  }

                  _onSubmit(state.data.map((e) => e.id).toList());
                } else {
                  if (mounted) {
                    IndicatorsUtils.hideCurrentSnackBar();
                  }
                }
              },
            ),
          ],
          child: ClockPage(
            clockAccept: widget.data,
            noteController: _noteController,
            showLocationAlert:
                widget.clockBody.workingFrom == WorkingFromType.office,
            onChangeFiles: (newValue) {
              setState(() {
                _files = newValue;
              });
            },
            onPressNext: _onSubmit,
          ),
        ),
      ),
    );
  }

  void _onSubmit([List<int>? filesId]) {
    _onSubmitAction(filesId);
  }

  void _onSubmitAction([List<int>? filesId]) {
    if (_files.isEmpty || filesId != null) {
      _attendanceBloc.add(
        GetAttendanceEvent(
          widget.clockBody.copyWith(
            notes: _noteController.text,
            filesId: filesId ?? [],
          ),
        ),
      );
    } else {
      _uploadFilesBloc.add(GetUploadFilesEvent(_files));
    }
  }

  void _onSuccess({AttendanceResponseModel? trackerConfig}) {
    GetIt.I<SaveAttendanceUseCase>().call(
      AttendanceOfflineEntity(
        date: DateTime.now(),
        clock: DateFormat('HH:mm').format(DateTime.now()),
        type: AttendanceClockType.clockIn,
        workFrom: widget.clockBody.workingFrom,
        notes: _noteController.text,
        latitude: widget.clockBody.latitude,
        longitude: widget.clockBody.longitude,
        localImage: '',
        imageId: widget.clockBody.imageId,
        isSynced: true,
      ),
    );
    BlocProvider.of<ClockButtonTypeBloc>(context)
        .add(const ClockButtonTypeFetched());

    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailAttendancePage(
          date: DateTime.now(),
          onBack: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
        ),
      ),
    );
  }
}
