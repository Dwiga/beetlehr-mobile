part of 'check_break_time_setting_bloc.dart';

abstract class CheckBreakTimeSettingEvent extends Equatable {
  const CheckBreakTimeSettingEvent();
}

class FetchCheckBreakTimeSettingEvent extends CheckBreakTimeSettingEvent {
  final bool refresh;

  const FetchCheckBreakTimeSettingEvent({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

