import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../../../attendance.dart';
import '../take_photo_page.dart';

class TakePhotoClockInPage extends StatefulWidget {
  const TakePhotoClockInPage({
    Key? key,
    required this.workingFrom,
  }) : super(key: key);

  final WorkingFromType workingFrom;

  @override
  _TakePhotoClockInPageState createState() => _TakePhotoClockInPageState();
}

class _TakePhotoClockInPageState extends State<TakePhotoClockInPage> {
  late UploadPhotoBloc _bloc;
  File? _currentFile;

  @override
  void initState() {
    _bloc = GetIt.I<UploadPhotoBloc>();
    _bloc.add(CancelUploadPhotoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _bloc.add(CancelUploadPhotoEvent());
        return true;
      },
      child: BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is UploadPhotoSuccess) {
          if (mounted) {
            IndicatorsUtils.hideCurrentSnackBar();
          }
          Navigator.pushReplacementNamed(
            context,
            '/attendance/clock-in/check-placement',
            arguments: {
              'imageId': state.data.id,
              'working_from': state.data.workingFrom,
            },
          );
        } else if (state is UploadPhotoLoading) {
          IndicatorsUtils.showLoadingSnackBar(context);
        } else if (state is UploadPhotoFailure) {
          IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
        }
      },
      child: TakePhotoPage(
        initialImage: _currentFile,
        onCapture: (image) {
          setState(() {
            _currentFile = image;
          });

          _bloc.add(GetUploadPhotoEvent(
            image: image,
            date: DateTime.now(),
            type: AttendanceClockType.clockIn,
            workingFrom: widget.workingFrom,
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}
