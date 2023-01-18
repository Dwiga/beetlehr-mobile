import 'dart:io';

import 'package:dependencies/dependencies.dart';

enum AvatarValidationError { invalid }

class AvatarFormZ extends FormzInput<File?, AvatarValidationError> {
  const AvatarFormZ.pure() : super.pure(null);
  const AvatarFormZ.dirty([File? value]) : super.dirty(value);

  @override
  AvatarValidationError? validator(File? value) {
    return null;
  }
}
