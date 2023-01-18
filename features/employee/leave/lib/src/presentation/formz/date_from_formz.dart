import 'package:dependencies/dependencies.dart';

enum DateFromValidationError { invalid }

class DateFromFormZ extends FormzInput<DateTime?, DateFromValidationError> {
  const DateFromFormZ.pure([DateTime? value]) : super.pure(value);
  const DateFromFormZ.dirty([DateTime? value]) : super.dirty(value);

  @override
  DateFromValidationError? validator(DateTime? value) {
    return value == null ? DateFromValidationError.invalid : null;
  }
}
