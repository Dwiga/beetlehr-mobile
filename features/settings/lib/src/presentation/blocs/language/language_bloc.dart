import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../../../settings.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final SetLanguageUseCase setLanguageUseCase;
  final GetLanguageUseCase getLanguageUseCase;

  LanguageBloc({
    required this.setLanguageUseCase,
    required this.getLanguageUseCase,
  }) : super(const LanguageState(country: null));

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is ChangeLanguageEvent) {
      final result = await setLanguageUseCase(LanguageParam(
        CountryModel(
          code: event.country.code,
          name: event.country.name,
          flag: event.country.flag,
          dialCode: event.country.dialCode,
        ),
      ));
      result.fold((l) => null, (r) => add(InitializeLanguageEvent()));
    } else if (event is InitializeLanguageEvent) {
      final result = await _getSavedCountry();
      if (result != null) yield LanguageState(country: result);
    }
  }

  Future<Country?> _getSavedCountry() async {
    final result = await getLanguageUseCase(NoParams());
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }
}
