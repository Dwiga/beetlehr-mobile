part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class InitializeLanguageEvent extends LanguageEvent {
  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final Country country;

  const ChangeLanguageEvent(this.country);
  @override
  List<Object> get props => [country];
}
