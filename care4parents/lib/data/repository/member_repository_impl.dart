import 'dart:io';

import 'package:care4parents/data/data_sources/member_remote_data_source.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/repositories/member_repository.dart';

import 'package:dartz/dartz.dart';

class MemberRepositoryImpl extends MemberRepository {
  final MemberRemoteDataSource remoteDataSource;

  MemberRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, ObjectCommonResult>> familyOtp(String phone) async {
    try {
      final result = await remoteDataSource.familyOtp(phone);
      if (result.confirmation == 'success') {
        print('Right familyOtp get >>>> ' + result.toString());
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.message, message: result.message));
      }
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
  Future<Either<AppError, FamilyMember>> familyOtpVerification(
      String phone, String otp, String phoneWithoutContrycode, type) async {
    if (type == 'member') {
      try {
        final member = await remoteDataSource.familyOtpVerification(
            phone, otp, phoneWithoutContrycode, type);
        print('Right familyOtpVerification get >>>> ' + member.toString());
        return Right(member);
      } on SocketException {
        return Left(AppError(AppErrorType.network));
      } on Exception {
        print(
          'Exception >>>>',
        );
        return Left(AppError(AppErrorType.api));
      } catch (error) {
        print('error' + error.toString());
        return (error);
      }
    } else {
      try {
        final member = await remoteDataSource.familyOtpVerification(
            phone, otp, phoneWithoutContrycode, type);
        print('Right familyOtpVerification get >>>> ' + member.toString());


        if (member != null && member.gender != "member.gender") {
          print('Right1111111 >>>> ' + member.toString());
          return Right(member);
        } else if (member != null && member.email == 'success') {
          print('Right1333333 >>>> ' + member.toString());
          return Right(member);
        } else {
          print('Right1444444 >>>> ' + member.toString());
          return Left(AppError(AppErrorType.network));
        }
      } on SocketException {
        return Left(AppError(AppErrorType.network));
      } on Exception {
        print(
          'Exception >>>>',
        );
        return Left(AppError(AppErrorType.api));
      } catch (error) {
        print('error' + error.toString());
        return (error);
      }
    }
  }
}
