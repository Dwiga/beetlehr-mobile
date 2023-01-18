part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final Country? country;

  const LanguageState({this.country});

  @override
  List<Object?> get props => [country];
}
