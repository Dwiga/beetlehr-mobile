import 'package:settings/src/domain/entities/server_entity.dart';

class CheckServerModel extends ServerEntity {
  const CheckServerModel(
      {required String name,
      required String url,
      required String logo,
      required String status})
      : super(name: name, url: url, logo: logo, status: status);

  factory CheckServerModel.fromJson(Map<String, dynamic> json) {
    return CheckServerModel(
        name: json['name'] ?? '',
        url: json['url'] ?? '',
        logo: json['logo'] ?? '',
        status: json['status'] ?? '');
  }
}

extension CheckServerModelX on ServerEntity {
  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'logo': logo,
        'status': status,
      };
}
