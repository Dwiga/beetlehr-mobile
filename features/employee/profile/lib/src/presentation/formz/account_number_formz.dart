import 'package:dependencies/dependencies.dart';

enum AccountNumberValidationError { invalid }

class AccountNumberFormZ
    extends FormzInput<String, AccountNumberValidationError> {
  const AccountNumberFormZ.pure() : super.pure('');
  const AccountNumberFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  AccountNumberValidationError? validator(String? value) {
    return (value ?? '').isNotEmpty
        ? null
        : AccountNumberValidationError.invalid;
  }
}
