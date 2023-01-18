import 'package:dependencies/dependencies.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.name,
    this.designation,
    required this.email,
    required this.phoneNumber,
    this.address,
    this.accountNumber,
    this.nip,
    this.image,
  });

  final String name;
  final String? designation;
  final String email;
  final String phoneNumber;
  final String? address;
  final String? accountNumber;
  final String? nip;
  final String? image;

  @override
  List<Object?> get props => [
        name,
        designation,
        email,
        phoneNumber,
        address,
        accountNumber,
        nip,
        image,
      ];

  @override
  bool get stringify => true;
}
