import 'package:dependencies/dependencies.dart';

enum NameValidationError { invalid }

class NameFormZ extends FormzInput<String, NameValidationError> {
  const NameFormZ.pure() : super.pure('');
  const NameFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return (value ?? '').isNotEmpty ? null : NameValidationError.invalid;
  }
}
