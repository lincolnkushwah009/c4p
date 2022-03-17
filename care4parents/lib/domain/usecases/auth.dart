import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/usecases/usecase.dart';

class Login extends UseCase<UserEntity, UserParams> {
  final AuthenticationRepository repository;

  Login(this.repository);

  @override
  Future<Either<AppError, UserEntity>> call(UserParams userParams) async {
    return await repository.logIn(userParams.email, userParams.password,userParams.phone_number);
  }
}

class Signup extends UseCase<UserEntity, UserParams> {
  final AuthenticationRepository repository;

  Signup(this.repository);

  @override
  Future<Either<AppError, UserEntity>> call(UserParams userParams) async {
    return await repository.signup(userParams.name, userParams.email,
        userParams.password, userParams.username, userParams.phone_number);
  }
}

class ForgotPassword extends UseCase<CommonResult, UserParams> {
  final AuthenticationRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Either<AppError, CommonResult>> call(UserParams userParams) async {
    return await repository.forgotPass(userParams.email);
  }
}
