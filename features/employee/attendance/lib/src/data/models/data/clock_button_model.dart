import 'package:dependencies/dependencies.dart';

class ClockButtonModel extends Equatable {
  final bool isAlreadyClockout;
  final ClockButtonType type;
  final ClockMessageType messageType;
  final BreakType breakType;
  final String? startBreakTime;

  const ClockButtonModel(
      {required this.isAlreadyClockout,
      required this.type,
      required this.messageType,
      required this.breakType,
      required this.startBreakTime});

  factory ClockButtonModel.fromJson(Map<String, dynamic> json) {
    return ClockButtonModel(
        isAlreadyClockout: json['is_already_clockout'] ?? false,
        type: clockButtonTypeFromString(json['type'] ?? ''),
        messageType: clockMessageTypeFromString(json['message_type'] ?? ''),
        breakType: breakTypeFromString(json['break_type'] ?? ''),
        startBreakTime: json['start_break_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'is_already_clockout': isAlreadyClockout,
      'type': type.toCode(),
      'message_type': messageType.toCode(),
      'break_type': breakType.toCode(),
      'break_time': startBreakTime
    };
  }

  @override
  List<Object?> get props =>
      [isAlreadyClockout, type, messageType, breakType, startBreakTime];
}

enum ClockButtonType {
  clockIn,
  clockOut,
  none,
}

enum BreakType {
  start,
  end,
  none,
}

enum ClockMessageType {
  clockIn,
  clockOut,
  alreadyAttendance,
  none,
}

extension ClockButtonTypeX on ClockButtonType {
  String toCode() {
    switch (this) {
      case ClockButtonType.clockIn:
        return 'clockin';
      case ClockButtonType.clockOut:
        return 'clockout';
      default:
        return 'none';
    }
  }
}

ClockButtonType clockButtonTypeFromString(String type) {
  switch (type) {
    case 'clockin':
      return ClockButtonType.clockIn;
    case 'clockout':
      return ClockButtonType.clockOut;
    default:
      return ClockButtonType.none;
  }
}

extension ClockMessageTypeX on ClockMessageType {
  String toCode() {
    switch (this) {
      case ClockMessageType.clockIn:
        return 'clockin';
      case ClockMessageType.clockOut:
        return 'clockout';
      case ClockMessageType.alreadyAttendance:
        return 'already clockout';
      default:
        return 'none';
    }
  }
}

ClockMessageType clockMessageTypeFromString(String type) {
  switch (type) {
    case 'clockin':
      return ClockMessageType.clockIn;
    case 'clockout':
      return ClockMessageType.clockOut;
    case 'already clockout':
      return ClockMessageType.alreadyAttendance;
    default:
      return ClockMessageType.none;
  }
}

extension BreakTypeX on BreakType {
  String toCode() {
    switch (this) {
      case BreakType.start:
        return 'start';
      case BreakType.end:
        return 'end';
      default:
        return 'none';
    }
  }
}

BreakType breakTypeFromString(String type) {
  switch (type) {
    case 'start':
      return BreakType.start;
    case 'end':
      return BreakType.end;
    default:
      return BreakType.none;
  }
}
