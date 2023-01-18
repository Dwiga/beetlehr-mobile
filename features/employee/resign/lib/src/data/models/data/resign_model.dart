import '../../../domain/domain.dart';

class ResignModel extends ResignEntity {
  const ResignModel({
    required int id,
    required String label,
    required ResignStatus status,
    required String date,
    required String endContract,
    String? reason,
    bool? isAccordingProcedure,
    String? urlFile,
    String? fileName,
  }) : super(
          id: id,
          label: label,
          status: status,
          date: date,
          endContract: endContract,
          reason: reason,
          isAccordingProcedure: isAccordingProcedure,
          urlFile: urlFile,
          fileName: fileName,
        );

  factory ResignModel.fromJson(Map<String, dynamic> json) {
    return ResignModel(
      id: json["id"] ?? 0,
      label: json["label"] ?? '',
      status: ResignStatusConverter.fromString(json["status"]) ??
          ResignStatus.waiting,
      date: json["date"] ?? '',
      endContract: json["end_contract"] ?? '',
      reason: json["reason"],
      isAccordingProcedure: json["is_according_procedure"],
      urlFile: json["url_file"],
      fileName: json["file_name"],
    );
  }
}

extension ResignModelX on ResignEntity {
  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "status": ResignStatusConverter.convertToString(status),
        "date": date,
        "end_contract": endContract,
        "reason": reason,
        "is_according_procedure": isAccordingProcedure,
        "url_file": urlFile,
        "file_name": fileName,
      };
}
