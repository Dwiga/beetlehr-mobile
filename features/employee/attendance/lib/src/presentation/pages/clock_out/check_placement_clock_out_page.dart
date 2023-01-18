import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../../attendance.dart';

class CheckPlacementClockOutPage extends StatefulWidget {
  final int imageId;
  final WorkingFromType workingFrom;

  const CheckPlacementClockOutPage({
    Key? key,
    required this.imageId,
    required this.workingFrom,
  }) : super(key: key);

  @override
  _CheckPlacementClockOutPageState createState() =>
      _CheckPlacementClockOutPageState();
}

class _CheckPlacementClockOutPageState
    extends State<CheckPlacementClockOutPage> {
  late CheckPlacementBloc _checkPlacementBloc;
  late AcceptClockBloc _acceptClockBloc;
  ClockBodyModel? _sendData;

  @override
  void initState() {
    _checkPlacementBloc = GetIt.I<CheckPlacementBloc>();
    _acceptClockBloc = GetIt.I<AcceptClockBloc>();
    _initLocation();
    super.initState();
  }

  void _initLocation() async {
    final location = await LocationUtils.getCurrentLocation(context: context);

    if (location != null) {
      _checkPlacementBloc.add(FetchCheckPlacementEvent(
        latitude: location.latitude,
        longitude: location.longitude,
        workingFrom: widget.workingFrom,
      ));
    } else {
      Geolocator.openLocationSettings();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckPlacementBloc>(
          create: (_) => _checkPlacementBloc,
        ),
        BlocProvider<AcceptClockBloc>(
          create: (_) => _acceptClockBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).clock_out)),
        body: BlocListener<AcceptClockBloc, AcceptClockState>(
          listener: (context, state) {
            if (state is AcceptClockLoading) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state is AcceptClockFailure) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
              IndicatorsUtils.showErrorSnackBar(context, state.failure.message);
            } else if (state is AcceptClockSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
              Navigator.pushNamed(context, '/attendance/clock-out', arguments: {
                'data': state.data,
                'clockBody': _sendData,
              });
            } else {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          },
          child: BlocBuilder<CheckPlacementBloc, CheckPlacementState>(
            builder: (context, state) {
              if (state is CheckPlacementSuccess) {
                return CheckPlacementPage(
                  data: state.data,
                  currentLatLng: state.currentLatLng,
                  showCurrentLocationStatus:
                      state.data.workingFrom == WorkingFromType.office,
                  showRadius: state.data.workingFrom == WorkingFromType.office,
                  onNext: () {
                    _checkAcceptClock(state.data, state.currentLatLng);
                  },
                );
              } else if (state is CheckPlacementFailure) {
                return Center(
                  child: ErrorMessageWidget(
                    message: state.failure.message,
                    onPress: _initLocation,
                  ),
                );
              } else {
                return const LoadingPlacementSection();
              }
            },
          ),
        ),
      ),
    );
  }

  void _checkAcceptClock(OfficePlacementEntity data, LatLng latLng) {
    setState(() {
      _sendData = ClockBodyModel(
        address: data.address,
        clock: DateFormat('HH:mm:ss').format(DateTime.now()),
        date: DateTime.now(),
        imageId: widget.imageId,
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        type: AttendanceType.clockOut,
        workingFrom: widget.workingFrom,
      );
    });

    _acceptClockBloc.add(GetCheckAcceptClockEvent(_sendData!));
  }

  @override
  void dispose() {
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}
