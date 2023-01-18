import 'package:dependencies/dependencies.dart';

enum DateValidationError { invalid }

class DateFormZ extends FormzInput<DateTime?, DateValidationError> {
  const DateFormZ.pure([DateTime? value]) : super.pure(value);
  const DateFormZ.dirty([DateTime? value]) : super.dirty(value);

  @override
  DateValidationError? validator(DateTime? value) {
    return value != null ? null : DateValidationError.invalid;
  }
}
