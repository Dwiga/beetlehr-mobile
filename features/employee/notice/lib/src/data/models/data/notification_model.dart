import '../../../../notice.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required int id,
    required String title,
    required String? description,
    required String date,
    required String? file,
  }) : super(
          id: id,
          title: title,
          description: description,
          date: date,
          file: file,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      date: json['date'],
    );
  }
}

extension NotificationModelX on NotificationEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file': file,
      'date': date,
    };
  }
}
