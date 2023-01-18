import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../auth.dart';

class LoginWithEmailUseCase implements UseCase<UserEntity, LoginEmailParams> {
  final AuthRepository repository;

  LoginWithEmailUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(LoginEmailParams params) async {
    return await repository.loginWithEmail({
      'email': params.email,
      'password': params.password,
    });
  }
}

class LoginEmailParams {
  final String email;
  final String password;

  LoginEmailParams({required this.email, required this.password});
}
