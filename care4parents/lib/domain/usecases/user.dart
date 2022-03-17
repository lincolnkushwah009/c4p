import 'dart:io';

import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:care4parents/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/usecases/usecase.dart';

class GetUser extends UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  @override
  Future<Either<AppError, UserEntity>> call(NoParams noParams) async {
    return await userRepository.getUser();
  }
}

class EditProfile extends UseCase<UserEntity, UserParams> {
  final UserRepository userRepository;

  EditProfile(this.userRepository);

  @override
  Future<Either<AppError, UserEntity>> call(UserParams userParams) async {
    return await userRepository.editProfile(userParams);
  }
}

class ChangeProfile extends UseCase<UserProfileResponse, String> {
  final UserRepository userRepository;

  ChangeProfile(this.userRepository);

  @override
  Future<Either<AppError, UserProfileResponse>> call(String file) async {
    return await userRepository.changeProfile(file);
  }
}
class EmailVerify extends UseCase<UserProfileResponse, String> {
  final UserRepository userRepository;

  EmailVerify(this.userRepository);

  @override
  Future<Either<AppError, UserProfileResponse>> call(String email) async {
    return await userRepository.emailVerify(email);
  }
}




class ChangePassword extends UseCase<UserEntity, UserParams> {
  final UserRepository userRepository;

  ChangePassword(this.userRepository);

  @override
  Future<Either<AppError, UserEntity>> call(UserParams userParams) async {
    return await userRepository.changePassword(userParams);
  }
}
