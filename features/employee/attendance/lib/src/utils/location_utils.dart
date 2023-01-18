import 'dart:developer';
import 'dart:io';

// import 'package:component/component.dart';
// import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
// import 'package:l10n/l10n.dart';

class LocationUtils {
  static Future<LatLng?> getCurrentLocation({BuildContext? context}) async {
    try {
      bool _serviceEnabled;
      LocationPermission _permissionGranted;

      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      }

      _permissionGranted = await Geolocator.checkPermission();
      if (_permissionGranted != LocationPermission.always) {
        if (context != null && Platform.isAndroid) {
          // await _showDialogAboutPermissionLocation(context);
        }
        _permissionGranted = await Geolocator.requestPermission();
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      log('ERROR: $e');
      return null;
    }
  }

//   static Future _showDialogAboutPermissionLocation(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (_) => AppAlertDialog(
//         body: Text(
//           S.current.track_location_permission_message(
//             GetIt.I<GlobalConfiguration>().getValue('app_name'),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text(S.current.yes),
//           )
//         ],
//       ),
//     );
//   }
}

extension FilesExtensions on List<File> {
  FormData toFormData() {
    return FormData.fromMap({
      'files[]': map(
        (file) => MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split('/').last,
        ),
      ).toList(),
    });
  }
}
