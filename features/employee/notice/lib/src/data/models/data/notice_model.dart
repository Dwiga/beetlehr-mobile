import '../../../../notice.dart';

class NoticeModel extends NoticeEntity {
  const NoticeModel({
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

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      date: json['date'],
    );
  }
}

extension NoticeModelX on NoticeEntity {
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
