import '../../../auth.dart';

/// User model object
class UserModel extends UserEntity {
  ///
  const UserModel({
    required int id,
    required String name,
    required String email,
    String? role,
    String? image,
  }) : super(
          id: id,
          name: name,
          email: email,
          role: role,
          image: image,
        );

  /// generate object data UserModel from Map/ json
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        image: json['image'],
      );

  /// generate object data UserModel from [UserEntity]
  factory UserModel.fromEntity(UserEntity user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        image: user.image,
      );

  @override
  List<Object?> get props => [id, name, email, role, image];

  @override
  bool get stringify => true;
}

extension UserModelX on UserEntity {
  /// generate data [UserModel] to Map/Json
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'image': image,
      };
}
