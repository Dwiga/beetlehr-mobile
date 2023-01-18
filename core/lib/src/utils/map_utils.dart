import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Utils method handling Maps View
class MapUtils {
  /// Calculate bouds center from LatLng array
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1 = 0;
    for (var latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}

///
extension LatLngX on LatLng {
  /// Check valid LatLng or not
  bool isValid() {
    var _lat = latitude;
    var _long = longitude;

    var isValidLat = _lat >= -90 && _lat <= 90;
    var isValidLong = _long >= -180 && _long <= 180;

    return isValidLat && isValidLong;
  }
}
