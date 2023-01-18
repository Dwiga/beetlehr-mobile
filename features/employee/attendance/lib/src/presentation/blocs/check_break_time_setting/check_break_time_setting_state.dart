part of 'check_break_time_setting_bloc.dart';

abstract class CheckBreakTimeSettingState extends Equatable {
  const CheckBreakTimeSettingState();
}

class CheckBreakTimeSettingInitial extends CheckBreakTimeSettingState {
  @override
  List<Object> get props => [];
}

class CheckBreakTimeSettingLoading extends CheckBreakTimeSettingState {
  @override
  List<Object> get props => [];
}

class CheckBreakTimeSettingSuccess extends CheckBreakTimeSettingState {
  final bool isCanClosePage;

  const CheckBreakTimeSettingSuccess({required this.isCanClosePage});

  @override
  List<Object> get props => [isCanClosePage];
}

class CheckBreakTimeSettingFailure extends CheckBreakTimeSettingState {
  final Failure failure;

  const CheckBreakTimeSettingFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
