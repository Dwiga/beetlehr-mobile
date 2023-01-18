import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

part 'payroll_detail_event.dart';
part 'payroll_detail_state.dart';

class PayrollDetailBloc extends Bloc<PayrollDetailEvent, PayrollDetailState> {
  final GetDetailPayrollUseCase useCase;
  PayrollDetailBloc(this.useCase) : super(PayrollDetailLoading());

  @override
  Stream<PayrollDetailState> mapEventToState(
    PayrollDetailEvent event,
  ) async* {
    if (event is FetchPayrollDetailEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<PayrollDetailState> _mapFetchDataToState(
      FetchPayrollDetailEvent event) async* {
    try {
      yield PayrollDetailLoading();
      final result = await useCase(event.id);

      yield* result.fold((l) async* {
        yield PayrollDetailFailure(l);
      }, (r) async* {
        yield PayrollDetailSuccess(r);
      });
    } catch (e) {
      yield PayrollDetailFailure(DefaultServerFailure(message: e.toString()));
    }
  }
}
