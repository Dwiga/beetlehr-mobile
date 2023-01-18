import 'package:dependencies/dependencies.dart';

class MetaDataApprovalModel extends Equatable {
  final String? startTime;
  final String? endTime;
  final int? duration;
  final String? typeLabel;
  final String? reason;
  final String? additionalFile;
  final String? note;

  const MetaDataApprovalModel(
      {required this.startTime,
      required this.endTime,
      required this.duration,
      required this.typeLabel,
      required this.reason,
      required this.additionalFile,
      required this.note});

  factory MetaDataApprovalModel.fromJson(Map<String, dynamic> json) {
    return MetaDataApprovalModel(
        startTime: json['start_date'],
        endTime: json['end_date'],
        duration: json['duration'] ?? 0,
        typeLabel: json['type_label'] ?? '',
        reason: json['reason'] ?? '',
        additionalFile: json['additional_file'] ?? '',
        note: json['note'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startTime,
      'end_date': endTime,
      'duration': duration,
      'type_label': typeLabel,
      'reason': reason,
      'additional_file': additionalFile
    };
  }

  @override
  List<Object?> get props =>
      [startTime, endTime, duration, typeLabel, reason, additionalFile, note];
}
