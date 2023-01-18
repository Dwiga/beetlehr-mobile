import 'package:dependencies/dependencies.dart';

enum URLValidationError { invalid }

class URLFormZ extends FormzInput<String, URLValidationError> {
  const URLFormZ.pure() : super.pure('');
  const URLFormZ.dirty([String value = '']) : super.dirty(value);

  static final RegExp _urlRegExp =
      RegExp(r'^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$');

  @override
  URLValidationError? validator(String? value) {
    return _urlRegExp.hasMatch((value ?? ''))
        ? null
        : URLValidationError.invalid;
  }
}
