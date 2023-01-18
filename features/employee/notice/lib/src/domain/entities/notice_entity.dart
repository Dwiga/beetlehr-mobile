import 'package:dependencies/dependencies.dart';

class NoticeEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String? file;
  final String date;

  const NoticeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, description, date, file];

  @override
  bool get stringify => true;
}
