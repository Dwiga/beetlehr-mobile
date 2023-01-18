import 'dart:io';

import 'package:dependencies/dependencies.dart';

enum FileValidationError { invalid }

class FileFormZ extends FormzInput<File?, FileValidationError> {
  const FileFormZ.pure([File? value]) : super.pure(value);
  const FileFormZ.dirty([File? value]) : super.dirty(value);

  static const List _allowExtensions = ['jpg', 'png', 'jpeg', 'pdf'];

  @override
  FileValidationError? validator(File? value) {
    return value != null &&
            _allowExtensions.contains(value.path.toLowerCase().split('.').last)
        ? null
        : FileValidationError.invalid;
  }
}
