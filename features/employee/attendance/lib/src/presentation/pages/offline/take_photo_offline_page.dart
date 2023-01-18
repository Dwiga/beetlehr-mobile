import 'dart:io';

import 'package:attendance/attendance.dart';
import 'package:flutter/material.dart';

import '../take_photo_page.dart';

class TakePhotoOfflinePage extends StatefulWidget {
  const TakePhotoOfflinePage({
    Key? key,
    required this.clockOut,
    required this.workingFrom,
  }) : super(key: key);

  final bool clockOut;
  final WorkingFromType workingFrom;

  @override
  _TakePhotoOfflinePageState createState() => _TakePhotoOfflinePageState();
}

class _TakePhotoOfflinePageState extends State<TakePhotoOfflinePage> {
  File? _currentPhoto;

  @override
  Widget build(BuildContext context) {
    return TakePhotoPage(
      showLoadingOnCapture: false,
      initialImage: _currentPhoto,
      onCapture: (file) {
        setState(() {
          _currentPhoto = file;
        });
      },
      onApply: () {
        if (_currentPhoto != null) {
          if (widget.clockOut) {
            Navigator.of(context).pushReplacementNamed(
                '/attendance/offline/clock-out',
                arguments: {
                  'photo_path': _currentPhoto?.path,
                  'working_from': widget.workingFrom,
                });
          } else {
            Navigator.of(context).pushReplacementNamed(
                '/attendance/offline/clock-in',
                arguments: {
                  'photo_path': _currentPhoto?.path,
                  'working_from': widget.workingFrom,
                });
          }
        }
      },
    );
  }
}
