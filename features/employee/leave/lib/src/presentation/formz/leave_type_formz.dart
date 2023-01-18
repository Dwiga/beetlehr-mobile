import 'package:dependencies/dependencies.dart';

enum LeaveTypeValidationError { invalid }

class LeaveTypeFormZ extends FormzInput<int?, LeaveTypeValidationError> {
  const LeaveTypeFormZ.pure([int? value]) : super.pure(value);
  const LeaveTypeFormZ.dirty([int? value]) : super.dirty(value);

  @override
  LeaveTypeValidationError? validator(int? value) {
    return value != null && value > 0 ? null : LeaveTypeValidationError.invalid;
  }
}
