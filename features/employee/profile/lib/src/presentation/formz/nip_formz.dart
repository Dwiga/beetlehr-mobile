import 'package:dependencies/dependencies.dart';

enum NipValidationError { invalid }

class NipFormZ extends FormzInput<String, NipValidationError> {
  const NipFormZ.pure() : super.pure('');
  const NipFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  NipValidationError? validator(String? value) {
    return (value ?? '').isNotEmpty ? null : NipValidationError.invalid;
  }
}
