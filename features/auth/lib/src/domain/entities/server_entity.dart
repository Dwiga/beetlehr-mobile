import 'package:dependencies/dependencies.dart';

class ServerEntity extends Equatable {
  final String name;
  final String url;
  final String logo;
  final String status;

  const ServerEntity({
    required this.name,
    required this.url,
    required this.logo,
    required this.status,
  });

  @override
  List<Object?> get props => [
        name,
        url,
        logo,
        status,
      ];

  @override
  bool get stringify => true;
}
