part of 'clock_button_type_bloc.dart';

abstract class ClockButtonTypeState extends Equatable {
  const ClockButtonTypeState();

  @override
  List<Object?> get props => [];
}

class ClockButtonTypeLoading extends ClockButtonTypeState {}

class ClockButtonTypeSuccess extends ClockButtonTypeState {
  final ClockButtonModel data;

  const ClockButtonTypeSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ClockButtonTypeFailure extends ClockButtonTypeState {}
