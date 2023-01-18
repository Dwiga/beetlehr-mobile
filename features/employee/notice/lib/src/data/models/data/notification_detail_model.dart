import '../../../../notice.dart';

class NotificationDetailModel extends NotificationDetailEntity {
  const NotificationDetailModel(
      {required int id,
      required String title,
      required String? description,
      required String? file,
      required String date})
      : super(
            id: id,
            title: title,
            description: description,
            file: file,
            date: date);

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    return NotificationDetailModel(
      id: json['id'],
      title: json['requester_name'],
      description: json['requester_image'] ?? '',
      file: json['requester_designation'],
      date: json['requester_placement'],
    );
  }
}

extension NotificationDetailModelX on NotificationDetailEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requester_name': title,
      'requester_image': description,
      'requester_designation': file,
      'requester_placment': date,
    };
  }
}
