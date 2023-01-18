part of 'clock_offline_button_type_bloc.dart';

abstract class ClockOfflineButtonTypeEvent extends Equatable {
  const ClockOfflineButtonTypeEvent();

  @override
  List<Object?> get props => [];
}

class ClockOfflineButtonTypeFetched extends ClockOfflineButtonTypeEvent {
  const ClockOfflineButtonTypeFetched();
}
