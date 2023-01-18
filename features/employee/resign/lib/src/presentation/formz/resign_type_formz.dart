import 'package:dependencies/dependencies.dart';

enum ResignTypeValidationError { invalid }

class ResignTypeFormZ extends FormzInput<int?, ResignTypeValidationError> {
  const ResignTypeFormZ.pure([int? value]) : super.pure(value);
  const ResignTypeFormZ.dirty([int? value]) : super.dirty(value);

  @override
  ResignTypeValidationError? validator(int? value) {
    return value != null && value >= 0 && value <= 1
        ? null
        : ResignTypeValidationError.invalid;
  }
}
