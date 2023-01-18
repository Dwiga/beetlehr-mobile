import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  bool isShowCamera = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _initCamera();
  }

  void _initCamera() async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    _cameras = await availableCameras();
    if (_cameras.length > 1) {
      _controller = CameraController(
        _cameras[1],
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _controller?.initialize().then((_) async {
        if (!mounted) {
          return;
        }
        setState(() {});
        try {
          await _controller?.setFlashMode(FlashMode.off);
        } catch (e) {
          log(e.toString());
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((_controller?.value.isInitialized ?? false) &&
        _controller?.value != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            !isShowCamera ? SizedBox() : CameraPreview(_controller!),
            _buildOverlay(),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }

  Widget _buildControllCapture() {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isShowCamera = false;
          });
          _onCapture();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.3),
          ),
          child: Container(
            margin: EdgeInsets.all(8),
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipPath(
                clipper: _CircleModePhoto(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: Container(
            height: 80,
            child: _buildControllCapture(),
          ),
        ),
      ],
    );
  }

  void _onCapture() async {
    try {
      if (_controller == null ||
          !(_controller?.value.isInitialized ?? false) ||
          (_controller?.value.isTakingPicture ?? false)) {
        return;
      }

      final file = await _controller?.takePicture();
      print(file?.path);

      if (file?.path != null) {
        Navigator.of(context).pop(File(file?.path ?? ''));
      }
      setState(() {});
      _initCamera();
    } on CameraException catch (e) {
      log(e.description ?? '');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _controller?.dispose();

    super.dispose();
  }
}

class _CircleModePhoto extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var reactPath = Path();

    var width = size.width / (1 + .5);
    var height = size.height / (1.2 + .5);
    reactPath.lineTo(width, height * 0.38);
    reactPath.cubicTo(
        width, height * 0.71, width * 0.78, height, width / 2, height);
    reactPath.cubicTo(width * 0.22, height, 0, height * 0.7, 0, height * 0.38);
    reactPath.cubicTo(0, height * 0.17, width * 0.22, 0, width / 2, 0);
    reactPath.cubicTo(
        width * 0.78, 0, width, height * 0.17, width, height * 0.38);
    reactPath.cubicTo(
        width, height * 0.38, width, height * 0.38, width, height * 0.38);

    path.addPath(reactPath, Offset(width / 4, height / 2.8));
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    path.fillType = PathFillType.evenOdd;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
