import 'dart:async';

import 'package:component/component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';
import 'package:core/core.dart';

import '../../../attendance.dart';

class CheckPlacementPage extends StatefulWidget {
  final OfficePlacementEntity data;
  final VoidCallback? onNext;
  final LatLng currentLatLng;
  final bool showRadius;
  final bool showCurrentLocationStatus;

  const CheckPlacementPage({
    Key? key,
    required this.data,
    this.onNext,
    required this.currentLatLng,
    this.showRadius = true,
    this.showCurrentLocationStatus = true,
  }) : super(key: key);

  @override
  _CheckPlacementPageState createState() => _CheckPlacementPageState();
}

class _CheckPlacementPageState extends State<CheckPlacementPage> {
  Set<Marker>? _markers;
  Set<Circle>? _circles;
  final Completer<GoogleMapController> _controller = Completer();

  LatLng get placementLatLng =>
      LatLng(widget.data.placementLatitude, widget.data.placementLongitude);

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        _initMarkers();
        _initCircles();
      }
    });
    super.initState();
  }

  void _initMarkers() async {
    final _data = <Marker>[];

    final _iconCurrent = await Utils.bitmapDesciptorConverter(
      'assets/images/marker/current.png',
      config: createLocalImageConfiguration(
        context,
        size: const Size(Dimens.dp100, Dimens.dp100),
      ),
    );

    final _iconOffice = await Utils.bitmapDesciptorConverter(
      'assets/images/marker/office.png',
      config: createLocalImageConfiguration(
        context,
        size: const Size(Dimens.dp100, Dimens.dp100),
      ),
    );

    _data.add(Marker(
      markerId: const MarkerId('current'),
      position: widget.currentLatLng,
      icon: _iconCurrent,
    ));

    _data.add(Marker(
      markerId: const MarkerId('office'),
      position: LatLng(
        widget.data.placementLatitude,
        widget.data.placementLongitude,
      ),
      icon: _iconOffice,
    ));

    if (mounted) {
      setState(() {
        _markers = _data.toSet();
      });
    }
  }

  void _initCircles() {
    if (widget.showRadius) {
      final _data = <Circle>[];
      _data.add(
        Circle(
          circleId: const CircleId('1'),
          center: LatLng(
            widget.data.placementLatitude,
            widget.data.placementLongitude,
          ),
          radius: widget.data.maxRadius,
          strokeWidth: 2,
        ),
      );

      if (mounted) {
        setState(() {
          _circles = _data.toSet();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: Dimens.dp300,
          child: Stack(
            children: [
              MapView(
                markers: _markers ?? {},
                circles: _circles ?? {},
                latLng: placementLatLng,
                onMapCreated: (ctrl) async {
                  _controller.complete(ctrl);

                  if (widget.currentLatLng.isValid() &&
                      placementLatLng.isValid()) {
                    Future.delayed(const Duration(milliseconds: 100)).then((_) {
                      ctrl.animateCamera(CameraUpdate.newLatLngBounds(
                          MapUtils.boundsFromLatLngList([
                            widget.currentLatLng,
                            placementLatLng,
                          ]),
                          60));
                    });
                  }
                },
              ),
              Positioned(
                top: Dimens.dp8,
                right: Dimens.dp12,
                child: InkWell(
                  onTap: () async {
                    final controller = await _controller.future;

                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: widget.currentLatLng,
                          zoom: 17,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(Dimens.dp8),
                      child: const Icon(Icons.gps_fixed),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: Dimens.dp28,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimens.dp16)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(Dimens.dp16, 0, Dimens.dp16, Dimens.dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showCurrentLocationStatus) ...[
            _buildAlert(),
            const SizedBox(height: Dimens.dp16)
          ],
          _buildTime(),
          const SizedBox(height: Dimens.dp16),
          _buildAddress(),
          const SizedBox(height: Dimens.dp16),
          _buildNote(),
          const SizedBox(height: Dimens.dp32),
          PrimaryButton(
              onPressed: widget.onNext, child: Text(S.of(context).next)),
        ],
      ),
    );
  }

  Widget _buildAlert() {
    return (widget.data.accepted)
        ? AlertMessage.success(
            Text(S.of(context).location_in_radius),
            icon: AppIcons.mapMarkerLine,
          )
        : AlertMessage.danger(
            Text(S.of(context).location_out_radius),
            icon: AppIcons.mapMarkerLine,
          );
  }

  Widget _buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegularText(
          S.of(context).time_location,
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        const SizedBox(height: Dimens.dp4),
        SubTitle2Text(DateFormat('HH:mm').format(DateTime.now())),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegularText(
          S.of(context).your_position,
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        const SizedBox(height: Dimens.dp4),
        SubTitle2Text(widget.data.address),
      ],
    );
  }

  Widget _buildNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegularText(
          S.of(context).note,
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        const SizedBox(height: Dimens.dp4),
        Row(
          children: [
            const Icon(
              AppIcons.mapMarkerSolid,
              color: Colors.red,
            ),
            SubTitle2Text(S.of(context).your_current_location),
          ],
        ),
        const SizedBox(height: Dimens.dp4),
        Row(
          children: [
            const Icon(
              AppIcons.mapMarkerSolid,
              color: Color(0xFF00C292),
            ),
            SubTitle2Text(S.of(context).your_office_location),
          ],
        ),
      ],
    );
  }
}

class MapView extends StatelessWidget {
  final LatLng latLng;
  final ValueChanged<GoogleMapController> onMapCreated;
  final Set<Marker>? markers;
  final Set<Circle>? circles;

  const MapView({
    Key? key,
    required this.latLng,
    required this.onMapCreated,
    this.markers,
    this.circles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _gestures = <Factory<OneSequenceGestureRecognizer>>[
      Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
      Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
      Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()),
    ];

    return GoogleMap(
      markers: markers ?? {},
      circles: circles ?? {},
      zoomControlsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 17,
      ),
      gestureRecognizers: _gestures.toSet(),
      onMapCreated: onMapCreated,
    );
  }
}
