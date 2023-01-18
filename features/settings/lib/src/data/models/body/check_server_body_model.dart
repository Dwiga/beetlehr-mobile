import 'package:dependencies/dependencies.dart';

class CheckServerBodyModel extends Equatable {
  const CheckServerBodyModel({
    required this.name,
    required this.url,
    required this.logo,
    required this.status,
  });

  final String name;
  final String url;
  final String logo;
  final String status;

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "logo": logo,
        "status": status,
      };

  @override
  List<Object?> get props => [name, url, logo, status];

  @override
  bool get stringify => true;
}
