import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:home_employee/home.dart';

import '../clock_page.dart';

class ClockInOfflinePage extends StatefulWidget {
  const ClockInOfflinePage({
    Key? key,
    required this.photoPath,
    required this.workingFrom,
  }) : super(key: key);

  final String photoPath;
  final WorkingFromType workingFrom;

  @override
  _ClockInOfflinePageState createState() => _ClockInOfflinePageState();
}

class _ClockInOfflinePageState extends State<ClockInOfflinePage> {
  late LatLng _location;
  late String _photoPath;

  bool _photoIsUsed = false;

  final _noteController = TextEditingController();

  @override
  void initState() {
    _validateData();
    super.initState();
  }

  Future _validateData() async {
    final isPhotoValid = await _validatePhotoPath();
    if (isPhotoValid) {
      final isLocationValid = await _initLocation();
      if (!isLocationValid) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _validatePhotoPath() async {
    try {
      final fileIsAvailable = await File(widget.photoPath).exists();

      if (!fileIsAvailable) {
        return false;
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        final dateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final copyFile = File(widget.photoPath)
            .copySync('${appDir.absolute.path}/$dateFormat-in.jpg');

        _photoPath = copyFile.path;
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _initLocation() async {
    final location = await LocationUtils.getCurrentLocation(context: context);

    if (location != null) {
      _location = location;
      return true;
    } else {
      Geolocator.openLocationSettings();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).clock_in + " Offline"),
      ),
      resizeToAvoidBottomInset: false,
      body: ClockPage(
        onPressNext: _saveAttendance,
        noteController: _noteController,
        clockAccept: const ClockAcceptModel(),
        requiredInputFiles: false,
        requiredInputNotes: false,
        showLocationAlert: false,
        showTimeAlert: false,
        showInputFiles: false,
      ),
    );
  }

  Future _saveAttendance() async {
    try {
      final result = await GetIt.I<SaveAttendanceUseCase>().call(
        AttendanceOfflineEntity(
          date: DateTime.now(),
          clock: DateFormat('HH:mm').format(DateTime.now()),
          type: AttendanceClockType.clockIn,
          workFrom: widget.workingFrom,
          notes: _noteController.text,
          latitude: _location.latitude,
          longitude: _location.longitude,
          localImage: _photoPath,
        ),
      );

      IndicatorsUtils.showLoadingSnackBar(context);

      result.fold((failure) {
        IndicatorsUtils.showErrorSnackBar(context, failure.message);
      }, (data) {
        if (mounted) {
          setState(() {
            _photoIsUsed = true;
          });
        }
        BlocProvider.of<ConnectionModeBloc>(context)
            .add(const ConnectionModeRefreshed());
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      });
    } catch (_) {
    } finally {
      IndicatorsUtils.hideCurrentSnackBar();
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    if (!_photoIsUsed) {
      try {
        File(widget.photoPath).deleteSync(recursive: true);
      } catch (_) {}
    }
    super.dispose();
  }
}
