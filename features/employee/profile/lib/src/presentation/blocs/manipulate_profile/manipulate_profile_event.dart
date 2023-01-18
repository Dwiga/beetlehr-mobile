part of 'manipulate_profile_bloc.dart';

abstract class ManipulateProfileEvent extends Equatable {}

class ManipulateProfileChangeName extends ManipulateProfileEvent {
  final String name;

  ManipulateProfileChangeName(this.name);

  @override
  List<Object> get props => [name];
}

class ManipulateProfileChangeEmail extends ManipulateProfileEvent {
  final String email;

  ManipulateProfileChangeEmail(this.email);

  @override
  List<Object> get props => [email];
}

class ManipulateProfileChangePhone extends ManipulateProfileEvent {
  final String phone;

  ManipulateProfileChangePhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class ManipulateProfileChangeAddress extends ManipulateProfileEvent {
  final String address;

  ManipulateProfileChangeAddress(this.address);

  @override
  List<Object> get props => [address];
}

class ManipulateProfileChangeAccountNumber extends ManipulateProfileEvent {
  final String number;

  ManipulateProfileChangeAccountNumber(this.number);

  @override
  List<Object> get props => [number];
}

class ManipulateProfileChangeAvatar extends ManipulateProfileEvent {
  final File image;

  ManipulateProfileChangeAvatar(this.image);

  @override
  List<Object> get props => [image];
}

class ManipulateProfileChangeImageUrl extends ManipulateProfileEvent {
  final String url;

  ManipulateProfileChangeImageUrl(this.url);

  @override
  List<Object> get props => [url];
}

class ManipulateProfileChangeNip extends ManipulateProfileEvent {
  final String nip;

  ManipulateProfileChangeNip(this.nip);

  @override
  List<Object> get props => [nip];
}

class ManipulateProfileSubmitted extends ManipulateProfileEvent {
  @override
  List<Object> get props => [];
}
