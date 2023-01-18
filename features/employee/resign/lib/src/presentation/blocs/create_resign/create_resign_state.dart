part of 'create_resign_bloc.dart';

class CreateResignState extends Equatable {
  final FormzStatus status;
  final DateFormZ submitDate;
  final DateFormZ endContractDate;
  final ReasonFormZ reason;
  final ResignTypeFormZ resignType;
  final FileFormZ file;
  final ResignEntity? data;
  final Failure? failure;

  const CreateResignState({
    this.status = FormzStatus.pure,
    this.submitDate = const DateFormZ.pure(),
    this.endContractDate = const DateFormZ.pure(),
    this.reason = const ReasonFormZ.pure(),
    this.resignType = const ResignTypeFormZ.pure(),
    this.file = const FileFormZ.pure(),
    this.data,
    this.failure,
  });

  CreateResignState copyWith({
    FormzStatus? status,
    DateFormZ? submitDate,
    DateFormZ? endContractDate,
    ReasonFormZ? reason,
    ResignTypeFormZ? resignType,
    FileFormZ? file,
    ResignEntity? data,
    Failure? failure,
  }) {
    return CreateResignState(
      status: status ?? this.status,
      submitDate: submitDate ?? this.submitDate,
      endContractDate: endContractDate ?? this.endContractDate,
      reason: reason ?? this.reason,
      resignType: resignType ?? this.resignType,
      file: file ?? this.file,
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        submitDate,
        endContractDate,
        reason,
        resignType,
        file,
        data,
        failure,
      ];

  @override
  bool get stringify => true;
}
