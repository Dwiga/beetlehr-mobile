import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:notice/notice.dart';

class RejectRequestUseCase
    implements UseCase<ApproverResponseEntity, RejectResponseParams> {
  final NoticeRepository repository;

  const RejectRequestUseCase(this.repository);

  @override
  Future<Either<Failure, ApproverResponseEntity>> call(
      RejectResponseParams params) async {
    return await repository.rejectRequest(params.body, params.id);
  }
}

class RejectResponseParams extends Equatable {
  final int id;
  final ApproverRequestBodyModel body;

  const RejectResponseParams({required this.id, required this.body});

  @override
  List<Object?> get props => [id, body];
}
