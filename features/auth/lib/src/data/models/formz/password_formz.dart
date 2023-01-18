import 'package:dependencies/dependencies.dart';

enum PasswordValidationError { invalid }

class PasswordFormZ extends FormzInput<String, PasswordValidationError> {
  const PasswordFormZ.pure() : super.pure('');
  const PasswordFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value != null ? null : PasswordValidationError.invalid;
  }
}
