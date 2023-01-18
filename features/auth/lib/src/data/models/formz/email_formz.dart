import 'package:dependencies/dependencies.dart';

enum EmailValidationError { invalid }

class EmailFormZ extends FormzInput<String, EmailValidationError> {
  const EmailFormZ.pure() : super.pure('');
  const EmailFormZ.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
