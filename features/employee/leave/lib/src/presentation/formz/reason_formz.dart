import 'package:dependencies/dependencies.dart';

enum ReasonValidationError { isEmpty }

class ReasonFormZ extends FormzInput<String, ReasonValidationError> {
  const ReasonFormZ.pure([String value = '']) : super.pure(value);
  const ReasonFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  ReasonValidationError? validator(String? value) {
    return (value ?? '').isEmpty ? ReasonValidationError.isEmpty : null;
  }
}
