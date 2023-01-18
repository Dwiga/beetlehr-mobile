import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, int> {
  BottomNavBloc() : super(0);

  @override
  Stream<int> mapEventToState(
    BottomNavEvent event,
  ) async* {
    if (event is ChangeBottomNavEvent) {
      yield event.index;
    }
  }
}
