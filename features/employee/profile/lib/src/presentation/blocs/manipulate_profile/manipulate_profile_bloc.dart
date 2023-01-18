import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../profile.dart';
import '../../formz/formz.dart';

part 'manipulate_profile_event.dart';
part 'manipulate_profile_state.dart';

class ManipulateProfileBloc
    extends Bloc<ManipulateProfileEvent, ManipulateProfileState> {
  final UpdateProfileUseCase useCase;

  ManipulateProfileBloc(this.useCase) : super(const ManipulateProfileState());

  String? _imageUrl;

  @override
  Stream<ManipulateProfileState> mapEventToState(
    ManipulateProfileEvent event,
  ) async* {
    if (event is ManipulateProfileChangeName) {
      yield _mapChangeNameToState(event, state);
    } else if (event is ManipulateProfileChangeEmail) {
      yield _mapChangeEmailToState(event, state);
    } else if (event is ManipulateProfileChangePhone) {
      yield _mapChangePhoneToState(event, state);
    } else if (event is ManipulateProfileChangeAddress) {
      yield _mapChangeAddressToState(event, state);
    } else if (event is ManipulateProfileChangeAccountNumber) {
      yield _mapChangeAccountNumberToState(event, state);
    } else if (event is ManipulateProfileChangeAvatar) {
      yield _mapChangeAvatarToState(event, state);
    } else if (event is ManipulateProfileChangeImageUrl) {
      _imageUrl = event.url;
    }
    // else if (event is ManipulateProfileChangeNip) {
    //   yield _mapChangeNipToState(event, state);
    // }
    else if (event is ManipulateProfileSubmitted) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  ManipulateProfileState _mapChangeNameToState(
    ManipulateProfileChangeName event,
    ManipulateProfileState state,
  ) {
    final name = NameFormZ.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.phone,
        state.address,
        state.accountNumber,
        state.avatar,
        // state.nip,
      ]),
    );
  }

  ManipulateProfileState _mapChangeEmailToState(
    ManipulateProfileChangeEmail event,
    ManipulateProfileState state,
  ) {
    final email = EmailFormZ.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        state.name,
        email,
        state.phone,
        state.address,
        state.accountNumber,
        state.avatar,
        // state.nip,
      ]),
    );
  }

  ManipulateProfileState _mapChangePhoneToState(
    ManipulateProfileChangePhone event,
    ManipulateProfileState state,
  ) {
    final phone = PhoneFormZ.dirty(event.phone);
    return state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.name,
        state.email,
        phone,
        state.address,
        state.accountNumber,
        state.avatar,
        // state.nip,
      ]),
    );
  }

  ManipulateProfileState _mapChangeAddressToState(
    ManipulateProfileChangeAddress event,
    ManipulateProfileState state,
  ) {
    final address = AddressFormZ.dirty(event.address);
    return state.copyWith(
      address: address,
      status: Formz.validate([
        state.name,
        state.email,
        state.phone,
        address,
        state.accountNumber,
        state.avatar,
        // state.nip,
      ]),
    );
  }

  ManipulateProfileState _mapChangeAccountNumberToState(
    ManipulateProfileChangeAccountNumber event,
    ManipulateProfileState state,
  ) {
    final accountNumber = AccountNumberFormZ.dirty(event.number);
    return state.copyWith(
      accountNumber: accountNumber,
      status: Formz.validate([
        state.name,
        state.email,
        state.phone,
        state.address,
        accountNumber,
        state.avatar,
        // state.nip,
      ]),
    );
  }

  ManipulateProfileState _mapChangeAvatarToState(
    ManipulateProfileChangeAvatar event,
    ManipulateProfileState state,
  ) {
    final avatar = AvatarFormZ.dirty(event.image);
    return state.copyWith(
      avatar: avatar,
      status: Formz.validate([
        state.name,
        state.email,
        state.phone,
        state.address,
        state.accountNumber,
        avatar,
        // state.nip,
      ]),
    );
  }

  // ManipulateProfileState _mapChangeNipToState(
  //   ManipulateProfileChangeNip event,
  //   ManipulateProfileState state,
  // ) {
  //   final nip = NipFormZ.dirty(event.nip);
  //   return state.copyWith(
  //     nip: nip,
  //     status: Formz.validate([
  //       state.name,
  //       state.email,
  //       state.phone,
  //       state.address,
  //       state.accountNumber,
  //       state.avatar,
  //       nip,
  //     ]),
  //   );
  // }

  Stream<ManipulateProfileState> _mapSubmittedToState(
    ManipulateProfileSubmitted event,
    ManipulateProfileState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final image = await _getImage(state);

        final result = await useCase(ProfileBodyModel(
          name: state.name.value,
          email: state.email.value,
          phone: state.phone.value,
          address: state.address.value,
          accountNumber: state.accountNumber.value,
          // nip: state.nip.value,
          image: image,
        ));

        yield* result.fold((l) async* {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: l,
          );
        }, (r) async* {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        });
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Future<File?> _getImage(ManipulateProfileState state) async {
    try {
      if (state.avatar.value != null) {
        return state.avatar.value!;
      } else if (_imageUrl != null) {
        log('GET: $_imageUrl');
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/${_imageUrl!.split('/').last}';

        final image = await Dio().download(_imageUrl!, path);

        if (image.data != null) {
          final file = File(path);
          log('RESPONSE DATA TYPE: ${image.data?.runtimeType}');
          return file;
        }
        return null;
      }
      return null;
    } on DioError catch (_) {
      return null;
    }
  }
}
