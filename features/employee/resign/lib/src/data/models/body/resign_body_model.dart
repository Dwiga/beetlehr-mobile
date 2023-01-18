import 'dart:io';

import 'package:dependencies/dependencies.dart';

class ResignBodyModel extends Equatable {
  final DateTime date;
  final String reason;
  final int isAccordingProcedure;
  final DateTime endContract;
  final File file;

  const ResignBodyModel({
    required this.date,
    required this.reason,
    required this.isAccordingProcedure,
    required this.endContract,
    required this.file,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'date': DateFormat('y-MM-dd').format(date),
      'reason': reason,
      'is_according_procedure': isAccordingProcedure,
      'end_contract': DateFormat('y-MM-dd').format(endContract),
      'file': await MultipartFile.fromFile(file.path),
    });
  }

  @override
  List<Object> get props =>
      [date, reason, isAccordingProcedure, endContract, file];
}
