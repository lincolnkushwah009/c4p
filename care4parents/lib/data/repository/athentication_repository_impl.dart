// import 'dart:async';
// import 'dart:io';

// import 'package:care4parents/data/data_sources/appointment_remote_data_source.dart';
// import 'package:care4parents/data/data_sources/user_remote_data_source.dart';
// import 'package:care4parents/data/models/appointment_model.dart';
// import 'package:care4parents/data/models/user.dart';
// import 'package:care4parents/domain/entities/app_error.dart';
// import 'package:care4parents/domain/entities/appointment_entity.dart';
// import 'package:care4parents/domain/repositories/appointment_repository.dart';
// import 'package:care4parents/domain/repositories/authentication_repository.dart';
// import 'package:dartz/dartz.dart';

// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// class AuthenticationRepositoryImpl extends AuthenticationRepository {
//   final UserRemoteDataSource remoteDataSource;
//   final _controller = StreamController<AuthenticationStatus>();

//   AuthenticationRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<Either<AppError, User>> logIn(email, password) async {
//     try {
//       final login = await remoteDataSource.login(email, password);
//       if (login != null) {
//         print('Right login ' + login.toString());
//         _controller.add(AuthenticationStatus.authenticated);
//         return Right(login);
//       } else {
//         print('no login data found');
//         _controller.add(AuthenticationStatus.unauthenticated);
//         return Left(AppError(AppErrorType.api));
//       }
//     } on SocketException {
//       print('network error login');
//       return Left(AppError(AppErrorType.network));
//     } on Exception {
//       return Left(AppError(AppErrorType.api));
//     } catch (error) {
//       print('api error login' + error.toString());
//       _controller.add(AuthenticationStatus.unauthenticated);
//       return Left(AppError(AppErrorType.api));
//     }
//   }

//   @override
//   Future<Either<AppError, void>> logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }

//   @override
//   Future<Either<AppError, void>> dispose() {
//     _controller.close();
//   }

//   // @override
//   // Stream<AuthenticationStatus> status() async* {
//   //   yield AuthenticationStatus.unauthenticated;
//   //   yield* _controller.stream;
//   // }

//   // Stream<AuthenticationStatus> status() async* {
//   //   yield AuthenticationStatus.unauthenticated;
//   //   yield* _controller.stream;
//   // }
// }
