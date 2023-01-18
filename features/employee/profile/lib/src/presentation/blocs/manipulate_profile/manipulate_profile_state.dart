part of 'manipulate_profile_bloc.dart';

class ManipulateProfileState extends Equatable {
  final FormzStatus status;
  final NameFormZ name;
  final EmailFormZ email;
  final PhoneFormZ phone;
  final AddressFormZ address;
  final AccountNumberFormZ accountNumber;
  final AvatarFormZ avatar;
  // final NipFormZ nip;
  final Failure? failure;

  const ManipulateProfileState({
    this.status = FormzStatus.pure,
    this.name = const NameFormZ.pure(),
    this.email = const EmailFormZ.pure(),
    this.phone = const PhoneFormZ.pure(),
    this.address = const AddressFormZ.pure(),
    this.accountNumber = const AccountNumberFormZ.pure(),
    this.avatar = const AvatarFormZ.pure(),
    // this.nip = const NipFormZ.pure(),
    this.failure,
  });

  ManipulateProfileState copyWith({
    FormzStatus? status,
    NameFormZ? name,
    EmailFormZ? email,
    PhoneFormZ? phone,
    AddressFormZ? address,
    AccountNumberFormZ? accountNumber,
    AvatarFormZ? avatar,
    NipFormZ? nip,
    Failure? failure,
  }) {
    return ManipulateProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      accountNumber: accountNumber ?? this.accountNumber,
      avatar: avatar ?? this.avatar,
      // nip: nip ?? this.nip,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        phone,
        address,
        accountNumber,
        avatar,
        // nip,
        failure,
      ];

  @override
  bool get stringify => true;
}
