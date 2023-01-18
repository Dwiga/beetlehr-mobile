import 'dart:async';
import 'dart:math';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

class ConnectionStatusSection extends StatefulWidget {
  const ConnectionStatusSection({
    Key? key,
    this.ignoreOffline = false,
    this.ignoreOnline = false,
    this.onSwitchToOnline,
    this.onSwitchToOffline,
  }) : super(key: key);

  final bool ignoreOffline;
  final bool ignoreOnline;
  final VoidCallback? onSwitchToOnline;
  final VoidCallback? onSwitchToOffline;

  @override
  _ConnectionStatusSectionState createState() =>
      _ConnectionStatusSectionState();
}

class _ConnectionStatusSectionState extends State<ConnectionStatusSection> {
  StreamSubscription<InternetConnectionStatus>? _connectionStatusStream;

  bool? isOnline;

  @override
  void initState() {
    _listenConnectionStatus();
    super.initState();
  }

  void _listenConnectionStatus() {
    _connectionStatusStream?.cancel();
    _connectionStatusStream =
        GetIt.I<InternetConnectionChecker>().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        setState(() {
          isOnline = true;
        });
      } else {
        setState(() {
          isOnline = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOnline == true && !widget.ignoreOnline) {
      return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: SliverPersistentHeader(
          pinned: true,
          delegate: _ConnectionStatusDelegate(
            height: kToolbarHeight,
            topPadding: MediaQuery.of(context).padding.top,
            collapseHeight: 0,
            backgroundColor: StaticColors.green,
            title: Center(
              child: Row(
                children: [
                  const Icon(Icons.network_check, size: Dimens.dp16),
                  const SizedBox(width: Dimens.dp8),
                  Expanded(child: Text(S.of(context).connected_to_network)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: Dimens.dp14,
                      ),
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size(Dimens.dp50, Dimens.dp32),
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.dp8, horizontal: Dimens.dp16),
                    ),
                    onPressed: widget.onSwitchToOnline,
                    child: Text(S.of(context).move_online),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (isOnline == false && !widget.ignoreOffline) {
      return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: SliverPersistentHeader(
          pinned: true,
          delegate: _ConnectionStatusDelegate(
            height: kToolbarHeight,
            topPadding: MediaQuery.of(context).padding.top,
            collapseHeight: 0,
            backgroundColor: StaticColors.red,
            title: Center(
              child: Row(
                children: [
                  const Icon(Icons.cloud_off, size: Dimens.dp16),
                  const SizedBox(width: Dimens.dp8),
                  Expanded(
                      child: Text(S.of(context).disconnected_from_network)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: Dimens.dp14,
                      ),
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size(Dimens.dp50, Dimens.dp32),
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.dp8, horizontal: Dimens.dp16),
                    ),
                    onPressed: widget.onSwitchToOffline,
                    child: Text(S.of(context).move_offline),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        pinned: true,
        delegate: _ConnectionStatusDelegate(
          height: MediaQuery.of(context).padding.top,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectionStatusStream?.cancel();
    super.dispose();
  }
}

class _ConnectionStatusDelegate extends SliverPersistentHeaderDelegate {
  const _ConnectionStatusDelegate({
    required this.height,
    this.title,
    this.collapseHeight,
    this.backgroundColor,
    this.topPadding = 0,
  });

  final double height;
  final double? collapseHeight;
  final Widget? title;
  final Color? backgroundColor;
  final double topPadding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentExtent =
        height > 1 ? max(minExtent, maxExtent - shrinkOffset) : height;

    return FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: currentExtent,
      child: AppBar(
        primary: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: title,
        titleTextStyle: const TextStyle(
          fontSize: Dimens.dp14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height + topPadding;

  @override
  double get minExtent => (collapseHeight ?? height) + topPadding;

  @override
  bool shouldRebuild(covariant _ConnectionStatusDelegate oldDelegate) =>
      title != oldDelegate.title ||
      backgroundColor != oldDelegate.backgroundColor;
}
