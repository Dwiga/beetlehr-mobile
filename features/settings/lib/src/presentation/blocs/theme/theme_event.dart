part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme theme;
  ChangeThemeEvent({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
