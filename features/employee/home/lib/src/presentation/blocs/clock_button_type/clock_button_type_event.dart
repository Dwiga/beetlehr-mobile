part of 'clock_button_type_bloc.dart';

abstract class ClockButtonTypeEvent extends Equatable {
  const ClockButtonTypeEvent();

  @override
  List<Object?> get props => [];
}

class ClockButtonTypeFetched extends ClockButtonTypeEvent {
  final bool refresh;

  const ClockButtonTypeFetched({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}
