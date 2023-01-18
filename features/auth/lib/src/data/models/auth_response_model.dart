import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import 'user_model.dart';

/// R
class AuthResponseModel extends Equatable {
  ///
  const AuthResponseModel({
    required this.user,
    required this.token,
    this.meta,
  });

  /// Access token user
  final String token;

  /// Meta data response API
  final MetaData? meta;

  /// User object data
  final UserModel user;

  /// Generate [AuthResponseModel] from Map
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        user: UserModel.fromJson(json["data"]),
        token: json["token"],
        meta: json["meta"] == null ? null : MetaData.fromJson(json["meta"]),
      );

  /// Generate Map<> data from [AuthResponseModel] object
  Map<String, dynamic> toJson() => {
        "data": user.toJson(),
        "token": token,
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [user, token, meta];

  @override
  bool get stringify => true;
}
