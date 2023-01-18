import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../auth.dart';

class ResetPasswordUseCase implements UseCase<bool, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(params.email);
  }
}

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({required this.email});
}
