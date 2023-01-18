import 'package:auth/auth.dart';

import '../../../../profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required String name,
    String? designation,
    required String email,
    required String phoneNumber,
    String? address,
    String? accountNumber,
    String? nip,
    String? image,
  }) : super(
          name: name,
          designation: designation,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          accountNumber: accountNumber,
          image: image,
          nip: nip,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["name"],
        designation: json["designation"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        accountNumber: json["account_number"],
        nip: json["nip"],
        image: json["image"],
      );
}

extension ProfileModelX on ProfileEntity {
  Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "account_number": accountNumber,
        "nip": nip,
        "image": image,
      };

  UserEntity toUser(int id) => UserEntity(
        id: id,
        name: name,
        email: email,
        image: image,
        role: designation,
      );
}
