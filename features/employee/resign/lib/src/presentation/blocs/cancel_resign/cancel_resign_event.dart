part of 'cancel_resign_bloc.dart';

abstract class CancelResignEvent extends Equatable {}

class GetCancelResignEvent extends CancelResignEvent {
  final int id;

  GetCancelResignEvent(this.id);

  @override
  List<Object> get props => [id];
}
