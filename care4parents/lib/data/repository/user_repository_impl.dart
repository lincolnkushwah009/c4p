import 'dart:io';

import 'package:care4parents/data/data_sources/user_remote_data_source.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, User>> getUser() async {
    try {
      final user = await remoteDataSource.getUser();
      print('Right user get >>>> ' + user.toString());
      return Right(user);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      print('Exception >>>>');
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('error' + error.toString());
      return (error);
    }
  }

  @override
  Future<Either<AppError, User>> editProfile(UserParams user) async {
    try {
      final user_result = await remoteDataSource.editProfile(user);
      print('Right user get >>>> ' + user_result.toString());
      return Right(user_result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      print('Exception >>>>');
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('error' + error.toString());
      return (error);
    }
  }

  @override
  Future<Either<AppError, User>> changePassword(UserParams userParams) async {
    try {
      final user_result = await remoteDataSource.changePassword(userParams);
      print('Right user put password >>>> ' + user_result.toString());
      return Right(user_result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      print('Exception user put password >>>>');
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('error in user put password >>>>' + error.toString());
      return (error);
    }
  }

  @override
  Future<Either<AppError, UserProfileResponse>> changeProfile(
      String file) async {
    try {
      final user_result = await remoteDataSource.changeProfile(file);
      // print('Right user put password >>>> ' + user_result.toString());
      return Right(user_result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      print('Exception user put password >>>>');
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('error in user changeProfile >>>>' + error.toString());
      return (error);
    }
  }
  @override
  Future<Either<AppError, UserProfileResponse>> emailVerify(
     String email) async {
    try {
      final user_result = await remoteDataSource.emailVerify(email);
      // print('Right user put password >>>> ' + user_result.toString());
      return Right(user_result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      print('Exception user put password >>>>');
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('error in user changeProfile >>>>' + error.toString());
      return (error);
    }
  }
}
