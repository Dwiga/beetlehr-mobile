part of 'create_resign_bloc.dart';

abstract class CreateResignEvent extends Equatable {}

class CreateResignChangeSubmitDate extends CreateResignEvent {
  final DateTime date;

  CreateResignChangeSubmitDate(this.date);

  @override
  List<Object> get props => [date];
}

class CreateResignChangeContractDate extends CreateResignEvent {
  final DateTime date;

  CreateResignChangeContractDate(this.date);

  @override
  List<Object> get props => [date];
}

class CreateResignChangeReason extends CreateResignEvent {
  final String reason;

  CreateResignChangeReason(this.reason);

  @override
  List<Object> get props => [reason];
}

class CreateResignChangeResignType extends CreateResignEvent {
  final int type;

  CreateResignChangeResignType(this.type);

  @override
  List<Object> get props => [type];
}

class CreateResignChangeFile extends CreateResignEvent {
  final File file;

  CreateResignChangeFile(this.file);

  @override
  List<Object> get props => [file];
}

class CreateResignSubmitted extends CreateResignEvent {
  @override
  List<Object> get props => [];
}
