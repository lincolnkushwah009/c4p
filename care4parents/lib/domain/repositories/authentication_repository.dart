import 'dart:async';
import 'dart:io';

import 'package:care4parents/data/data_sources/user_remote_data_source.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/data/models/user_result.dart';
import 'package:care4parents/data/repository/athentication_repository_impl.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/social_login_params.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

// abstract class AuthenticationRepository {
//   Future<Either<AppError, User>> logIn(String email, String password);
//   Future<Either<AppError, void>> logOut();
//   Future<Either<AppError, void>> dispose();
//   // Stream<AuthenticationStatus> status() async* {
//   //   yield AuthenticationStatus.unauthenticated;
//   //   yield* _controller.stream;
//   // }
//   // Stream<AuthenticationStatus> status();
// }

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final UserRemoteDataSource remoteDataSource;
  AuthenticationRepository(this.remoteDataSource);

  final _controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<Either<AppError, User>> logIn(email, password, phone_number) async {
    assert(email != null);
    assert(password != null);

    try {
      return await remoteDataSource.login(email, password, phone_number);
      // print(login);
      // // login.fold((l) {
      // print('Left login ' + l.toString());

      // _controller.add(AuthenticationStatus.unauthenticated);

      // return AppError(AppErrorType.api, message: 'left message');
      // // }, (r) {
      // print('Right login ' + r.toString());

      // _controller.add(AuthenticationStatus.authenticated);
      // return Right(login);
      // // });
      // // if (login != null) {
      // // } else {
      // //   print('no login data found');
      // //   return Left(AppError(AppErrorType.api));
      // // }
    } on SocketException {
      print('network error login');
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('api error login' + error.toString());
      _controller.add(AuthenticationStatus.unauthenticated);
      return Left(AppError(AppErrorType.api));
    }
  }

  // Future<Either<AppError, User>> socaliLogin(email, password) async {
  //   assert(email != null);
  //   assert(password != null);

  //   try {
  //     final login = await remoteDataSource.login(email, password);
  //     if (login != null) {
  //       print('Right login ' + login.toString());
  //       _controller.add(AuthenticationStatus.authenticated);
  //       return Right(login);
  //     } else {
  //       print('no login data found');
  //       _controller.add(AuthenticationStatus.unauthenticated);
  //       return Left(AppError(AppErrorType.api));
  //     }
  //   } on SocketException {
  //     print('network error login');
  //     return Left(AppError(AppErrorType.network));
  //   } on Exception {
  //     return Left(AppError(AppErrorType.api));
  //   } catch (error) {
  //     print('api error login' + error.toString());
  //     _controller.add(AuthenticationStatus.unauthenticated);
  //     return Left(AppError(AppErrorType.api));
  //   }
  // }

  Future<Either<AppError, User>> signup(
      name, email, password, username, phone_number) async {
    assert(email != null);
    assert(password != null);
    assert(name != null);
    assert(username != null);

    try {
      return await remoteDataSource.signup(
          email, password, username, name, phone_number);
      // if (signup != null) {
      //   print('Right signup ' + signup.toString());
      //   // return Right(signup);
      // } else {
      //   print('no signup data found');
      //   // return Left(AppError(AppErrorType.api));
      // }
    } on SocketException {
      print('network error signup');
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print(error);
      return Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, CommonResult>> forgotPass(email) async {
    assert(email != null);
    try {
      final forgot_password = await remoteDataSource.forgotPass(email);
      if (forgot_password != null) {
        print('Right forgot password = ' + forgot_password.toString());
        return Right(forgot_password);
      } else {
        print('no forgot password = data found');
        return Left(AppError(AppErrorType.api));
      }
    } on SocketException {
      print('network error forgot password');
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    } catch (error) {
      print('api error forgot password' + error.toString());
      return Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, User>> socialLogin(SocialLoginParams params) async {
    try {
      final login = await remoteDataSource.socialLogin(params);
      if (login != null) {
        print('Right login = ' + login.toString());
        return Right(login);
      } else {
        print('no login = data found');
        return Left(
            AppError(AppErrorType.api, message: params.toJson().toString()));
      }
    } on SocketException {
      print('network error login');
      return Left(
          AppError(AppErrorType.network, message: params.toJson().toString()));
    } on Exception {
      return Left(
          AppError(AppErrorType.api, message: params.toJson().toString()));
    } catch (error) {
      print('api error login' + error.toString());
      return Left(
          AppError(AppErrorType.api, message: params.toJson().toString()));
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
