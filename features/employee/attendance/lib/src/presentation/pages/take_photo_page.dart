import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';
import 'package:settings/settings.dart';

class TakePhotoPage extends StatefulWidget {
  final ValueChanged<File>? onCapture;
  final File? initialImage;
  final bool showLoadingOnCapture;
  final VoidCallback? onApply;

  const TakePhotoPage({
    Key? key,
    this.onCapture,
    this.initialImage,
    this.showLoadingOnCapture = true,
    this.onApply,
  }) : super(key: key);

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        _onCapture();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          widget.initialImage != null
              ? _buildPicture()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          if (widget.initialImage != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: Dimens.dp16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildReControllReTakePhoto(),
                  if (widget.onApply != null) ...[
                    const SizedBox(width: Dimens.dp16),
                    _buildApplyPhotoButton(),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPicture() {
    return Image.file(
      widget.initialImage!,
      fit: BoxFit.fitWidth,
      width: Dimens.width(context),
      height: Dimens.height(context),
    );
  }

  Widget _buildReControllReTakePhoto() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
      ),
      child: InkWell(
        onTap: _onCapture,
        borderRadius: BorderRadius.circular(Dimens.dp50),
        child: Container(
          margin: const EdgeInsets.all(Dimens.dp8),
          padding: const EdgeInsets.all(Dimens.dp10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.highlight_off,
            color: StaticColors.red,
            size: Dimens.dp32,
          ),
        ),
      ),
    );
  }

  Widget _buildApplyPhotoButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
      ),
      child: InkWell(
        onTap: widget.onApply,
        borderRadius: BorderRadius.circular(Dimens.dp50),
        child: Container(
          margin: const EdgeInsets.all(Dimens.dp8),
          padding: const EdgeInsets.all(Dimens.dp10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.check,
            color: StaticColors.green,
            size: Dimens.dp32,
          ),
        ),
      ),
    );
  }

  void _logError(Object e) {
    if (e is PlatformException) {
      _sendLogError(e);
    } else {
      log(e.toString());
    }
  }

  void _sendLogError(PlatformException exception) {
    log(exception.toString());
    GetIt.I<RecordErrorUseCase>()(
      RecordErrorParams(
        exception: exception,
        library: 'camera',
        tags: const ['camera'],
        errorMessage: 'Error Custom Camera: ${exception.message}',
        stackTrace: StackTrace.fromString(exception.stacktrace ?? ''),
      ),
    );
  }

  void _onCapture() async {
    try {
      final file = await NativeCamera.takePhoto(
          context, CameraParams(lensType: LensType.front));

      if (widget.onCapture != null && file != null) {
        if (widget.showLoadingOnCapture) {
          IndicatorsUtils.showLoadingSnackBar(context);
        }
        widget.onCapture?.call(file);
        if (mounted) setState(() {});
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      _logError(e);
    }
  }

  @override
  void dispose() {
    try {} catch (e) {
      _logError(e);
    }

    super.dispose();
  }
}
