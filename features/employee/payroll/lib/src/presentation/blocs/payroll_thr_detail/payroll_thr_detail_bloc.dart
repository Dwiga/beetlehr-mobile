import 'dart:async';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../payroll.dart';

part 'payroll_thr_detail_event.dart';
part 'payroll_thr_detail_state.dart';

class PayrollTHRDetailBloc
    extends Bloc<PayrollTHRDetailEvent, PayrollTHRDetailState> {
  final GetDetailPayrollTHRUseCase useCase;
  PayrollTHRDetailBloc(this.useCase) : super(PayrollTHRDetailLoading());

  @override
  Stream<PayrollTHRDetailState> mapEventToState(
    PayrollTHRDetailEvent event,
  ) async* {
    if (event is FetchPayrollTHRDetailEvent) {
      yield* _mapFetchDataToState(event);
    }
  }

  Stream<PayrollTHRDetailState> _mapFetchDataToState(
      FetchPayrollTHRDetailEvent event) async* {
    try {
      yield PayrollTHRDetailLoading();
      final result = await useCase(event.id);

      yield* result.fold((l) async* {
        yield PayrollTHRDetailFailure(l);
      }, (r) async* {
        yield PayrollTHRDetailSuccess(r);
      });
    } catch (e) {
      yield PayrollTHRDetailFailure(
          DefaultServerFailure(message: e.toString()));
    }
  }
}
