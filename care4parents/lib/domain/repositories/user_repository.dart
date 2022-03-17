import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<AppError, User>> getUser();
  Future<Either<AppError, User>> editProfile(UserParams userParams);
  Future<Either<AppError, User>> changePassword(UserParams userParams);
  Future<Either<AppError, UserProfileResponse>> changeProfile(String file);
  Future<Either<AppError, UserProfileResponse>> emailVerify(String email);

}
