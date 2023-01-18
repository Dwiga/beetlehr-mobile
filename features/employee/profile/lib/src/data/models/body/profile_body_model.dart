import 'dart:io';

import 'package:dependencies/dependencies.dart';

class ProfileBodyModel {
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? accountNumber;
  final String? nip;
  final File? image;

  ProfileBodyModel({
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.accountNumber,
    this.nip,
    this.image,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'email': email,
      'phone_number': phone,
      'address': address,
      'account_number': accountNumber,
      'nip': nip,
      'image': image != null ? await MultipartFile.fromFile(image!.path) : null,
    });
  }
}
