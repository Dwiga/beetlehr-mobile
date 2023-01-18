import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

/// Utils for all indicators, for example loading, error message,
/// success message, etc
class IndicatorsUtils {
  /// Show loading indicator
  /// [context] param must child of [Scaffold] widget
  static void showLoadingSnackBar(BuildContext context) {
    hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (_) {},
          child: Row(
            children: [
              Expanded(child: Text('${S.of(context).please_wait}...')),
              const CircularProgressIndicator(),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(days: 1),
      ),
    );
  }

  /// Show Error indicator
  /// [context] param must child of [Scaffold] widget
  static void showErrorSnackBar(BuildContext context, String? errorMessage) {
    hideCurrentSnackBar();
    if (errorMessage != null && errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            content: Row(
              children: [
                Expanded(
                    child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
    }
  }

  /// Show success snackbar
  static void showSuccessSnackbar(BuildContext context, String message) {
    hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Row(
            children: [
              Expanded(
                  child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              )),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
  }

  /// Show success snackbar
  static void showMessageSnackbar(BuildContext context, String message) {
    hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              Expanded(
                  child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              )),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  /// Hide current snackbar, when current scaffold available snackbar active
  static void hideCurrentSnackBar() {
    GetIt.I<GlobalKey<ScaffoldMessengerState>>().currentState
      ?..hideCurrentSnackBar()
      ..removeCurrentSnackBar();
  }
}
