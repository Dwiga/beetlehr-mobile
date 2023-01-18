import '../../../../auth.dart';

class ServerModel extends ServerEntity {
  const ServerModel(
      {required String name,
      required String url,
      required String logo,
      required String status})
      : super(name: name, url: url, logo: logo, status: status);

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
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
