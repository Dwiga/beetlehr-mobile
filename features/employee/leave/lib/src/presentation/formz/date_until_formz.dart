import 'package:dependencies/dependencies.dart';

enum DateUntilValidationError { invalid }

class DateUntilFormZ extends FormzInput<DateTime?, DateUntilValidationError> {
  const DateUntilFormZ.pure([DateTime? value, this.startDate])
      : super.pure(value);
  const DateUntilFormZ.dirty({required DateTime value, required this.startDate})
      : super.dirty(value);

  final DateTime? startDate;

  @override
  DateUntilValidationError? validator(DateTime? value) {
    if (value != null &&
        startDate != null &&
        (value.isAfter(startDate!) ||
            _formatDate(value) == _formatDate(startDate!))) {
      return null;
    }
    return DateUntilValidationError.invalid;
  }

  DateTime _formatDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
