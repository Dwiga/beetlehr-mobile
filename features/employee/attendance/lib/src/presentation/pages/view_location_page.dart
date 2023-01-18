import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../attendance.dart';

class ViewLocationPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const ViewLocationPage({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _ViewLocationPageState createState() => _ViewLocationPageState();
}

class _ViewLocationPageState extends State<ViewLocationPage> {
  final List<Marker> _markers = [];

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) _getMarkers();
    });
    super.initState();
  }

  void _getMarkers() async {
    _markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(widget.latitude, widget.longitude),
      icon: await Utils.bitmapDesciptorConverter(
        'assets/images/marker/current.png',
        config: createLocalImageConfiguration(
          context,
          size: const Size(Dimens.dp100, Dimens.dp100),
        ),
      ),
    ));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view_location),
      ),
      body: MapView(
        markers: _markers.toSet(),
        onMapCreated: (_) {},
        latLng: LatLng(widget.latitude, widget.longitude),
      ),
    );
  }
}
