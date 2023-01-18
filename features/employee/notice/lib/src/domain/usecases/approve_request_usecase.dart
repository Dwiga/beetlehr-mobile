import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:notice/notice.dart';

class ApproveRequestUseCase
    implements UseCase<ApproverResponseEntity, ApproveResponseParams> {
  final NoticeRepository repository;

  const ApproveRequestUseCase(this.repository);

  @override
  Future<Either<Failure, ApproverResponseEntity>> call(
      ApproveResponseParams params) async {
    return await repository.approveRequest(params.body, params.id);
  }
}

class ApproveResponseParams extends Equatable {
  final int id;
  final ApproverRequestBodyModel body;

  const ApproveResponseParams({required this.id, required this.body});

  @override
  List<Object?> get props => [id, body];
}
