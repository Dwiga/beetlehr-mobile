import 'package:dependencies/dependencies.dart';

import '../enum/resign_status.dart';

class ResignEntity extends Equatable {
  const ResignEntity({
    required this.id,
    required this.label,
    required this.status,
    required this.date,
    required this.endContract,
    this.reason,
    this.isAccordingProcedure,
    this.urlFile,
    this.fileName,
  });

  final int id;
  final String label;
  final ResignStatus status;
  final String date;
  final String endContract;
  final String? reason;
  final bool? isAccordingProcedure;
  final String? urlFile;
  final String? fileName;

  @override
  List<Object?> get props => [
        id,
        label,
        status,
        date,
        endContract,
        reason,
        isAccordingProcedure,
        urlFile,
        fileName,
      ];

  @override
  bool? get stringify => true;
}
