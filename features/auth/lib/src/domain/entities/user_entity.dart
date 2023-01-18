import 'package:dependencies/dependencies.dart';

/// Entity simple user profile
///
class UserEntity extends Equatable {
  /// Id user
  final int id;

  /// Full name of user
  final String name;

  /// Email user
  final String email;

  /// Role user
  final String? role;

  /// Image avatar
  final String? image;

  ///
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        role,
        image,
      ];

  @override
  bool get stringify => true;
}
