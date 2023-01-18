import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

export 'indicators_utils.dart';
export 'map_utils.dart';
export 'network_utils.dart';

/// Basic Utils
class Utils {
  /// Example format : 22:00:00
  /// [hour]:[minutes]:[seconds]
  static Duration? durationTimeParse(String? time) {
    if (time == null) {
      return null;
    }
    var _parse = time.split(':');
    return Duration(
      hours: int.tryParse(_parse.first) ?? 0,
      minutes: int.tryParse(_parse[1]) ?? 0,
      seconds: int.tryParse(_parse[2]) ?? 0,
    );
  }

  /// Format from duration to valid duration string
  ///
  /// Example output: 22:00:00
  static String? durationTimeToString(Duration? duration) {
    if (duration == null) {
      return null;
    }

    return duration.toString().split('.').first.padLeft(8, '0');
  }

  /// Convert from duration to String time clock
  ///
  /// Example output: 18.00
  static String? durationToClock(Duration? duration) {
    if (duration == null) {
      return null;
    }

    var _parse = duration.toString().split(':');
    final _hours = _parse.first.length == 1 ? '0${_parse.first}' : _parse.first;
    final _minutes = _parse[1].length == 1 ? '0${_parse[1]}' : _parse[1];

    return '$_hours.$_minutes';
  }

  /// Converting from dynamic value type,
  /// for example when from API response String or double value,
  ///
  /// But you don't know type data
  ///
  /// Example use:
  ///
  /// ```dart
  /// Utils.intParser('123'); // return 123
  /// Utils.intParser('123.1'); // return 123
  /// Utils.intParser(123.1); // return 123
  /// ```
  static int? intParser(dynamic value) {
    try {
      if (value is int) {
        return value;
      } else if (value is double) {
        return value.toInt();
      } else if (value is String) {
        return int.tryParse(value);
      }
      // ignore: avoid_returning_null
      return null;
    } on FormatException catch (_) {
      // ignore: avoid_returning_null
      return null;
    }
  }

  /// Converting from dynamic value type,
  /// for example when from API response String or int value,
  ///
  /// But you don't know type data
  ///
  /// Example use:
  ///
  /// ```dart
  /// Utils.intParser('123'); // return 123.0
  /// Utils.intParser('123.1'); // return 123.1
  /// Utils.intParser(123.1); // return 123.1
  /// Utils.intParser(123); // return 123.0
  /// ```
  static double? doubleParser(dynamic value) {
    try {
      if (value is double) {
        return value;
      } else if (value is int) {
        return value.toDouble();
      } else if (value is String) {
        return double.tryParse(value);
      }
      // ignore: avoid_returning_null
      return null;
    } on FormatException catch (_) {
      // ignore: avoid_returning_null
      return null;
    }
  }

  /// Price formatter for Rupiah
  static String? rupiahFormatter(double? price) {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'IDR',
      decimalDigits: 0,
    );

    if (price != null) {
      return formatCurrency.format(price);
    }
    return null;
  }

  /// Converting from assets images to [BitmapDescriptor]
  static Future<BitmapDescriptor> bitmapDesciptorConverter(String imagePath,
      {required ImageConfiguration config}) async {
    final result = await BitmapDescriptor.fromAssetImage(config, imagePath);

    return result;
  }

  // Converts a date into a humanized text.
  // Instead of showing a date 2020-12-12 18:30 with timeago you can display something
  // like "now", "an hour ago", "~1y", etc
  static String? timeAgoSinceDate(
      {bool numericDates = false, String? createdTime}) {
    if (createdTime == null) {
      return null;
    }

    var inputFormat = DateFormat('y-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(createdTime.toString());

    DateTime date = inputDate.toLocal();
    final date2 = DateTime.now().toLocal();
    final difference = date2.difference(date);

    if (difference.inSeconds < 5) {
      return 'Just now';
    } else if (difference.inSeconds <= 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes <= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inMinutes <= 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours <= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inHours <= 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays <= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inDays <= 6) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if ((difference.inDays / 7).ceil() <= 4) {
      return '${(difference.inDays / 7).ceil()} weeks ago';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 30).ceil() <= 30) {
      return '${(difference.inDays / 30).ceil()} months ago';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    }
    return '${(difference.inDays / 365).floor()} years ago';
  }
}

extension DateTimeX on DateTime {
  bool isToday() {
    final current = DateFormat('y-MM-dd').format(this);
    final today = DateFormat('y-MM-dd').format(DateTime.now());

    return current == today;
  }

  bool isSameDay(DateTime date) {
    final current = DateFormat('y-MM-dd').format(this);
    final compare = DateFormat('y-MM-dd').format(date);

    return current == compare;
  }
}
