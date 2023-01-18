import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../notice.dart';

class GetEmployeeNameFilterUseCase
    implements
        UseCase<PaginateData<List<EmployeeNameFilterEntity>, MetaData>,
            EmployeeNameFilterParams> {
  final NoticeRepository repository;

  GetEmployeeNameFilterUseCase(this.repository);
  @override
  Future<
      Either<Failure,
          PaginateData<List<EmployeeNameFilterEntity>, MetaData>>> call(
      EmployeeNameFilterParams params) async {
    return await repository.getEmployeeNameFilter(
        perPage: params.perPage, page: params.page, name: params.name);
  }
}

class EmployeeNameFilterParams {
  final int perPage;
  final int page;
  final String name;

  EmployeeNameFilterParams(
      {required this.perPage, required this.page, required this.name});
}
