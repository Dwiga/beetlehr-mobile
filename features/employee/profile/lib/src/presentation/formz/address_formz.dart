import 'package:dependencies/dependencies.dart';

enum AddressValidationError { invalid }

class AddressFormZ extends FormzInput<String, AddressValidationError> {
  const AddressFormZ.pure() : super.pure('');
  const AddressFormZ.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String? value) {
    return (value ?? '').isNotEmpty ? null : AddressValidationError.invalid;
  }
}
