import 'dart:io';
import 'dart:convert';

import 'package:care4parents/data/data_sources/subscription_remote_data_source.dart';
import 'package:care4parents/data/models/array_common_result.dart';
import 'package:care4parents/data/models/coupon_code_result.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/member_result.dart';
import 'package:care4parents/data/models/member_service_mapping_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/rozar_pay_result.dart';
import 'package:care4parents/data/models/update_family_member_result.dart';
import 'package:care4parents/data/models/user_family_main_result.dart';
import 'package:care4parents/data/models/user_package_mapping_result.dart';
import 'package:care4parents/data/models/order_result.dart';
import 'package:care4parents/data/models/vital_top_result.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/domain/repositories/subscription_repository.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:dartz/dartz.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<Package>>> getPackages() async {
    try {
      final packages = await remoteDataSource.getPackages();
      return Right(packages);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MemberResultModel>> createMember(
      MemberParams memberParams) async {
    try {
      final member = await remoteDataSource.createMember(memberParams);
      print('member repo imp =>' + member.toJson().toString());
      return Right(member);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> createFamilyMapping(
      MemberMappingParams params) async {
    try {
      final result = await remoteDataSource.createFamilyMapping(params);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, OrderResult>> createOrder(OrderParams params) async {
    try {
      final result = await remoteDataSource.createOrder(params);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, UserPackageMappingResult>> createUserPackageMapping(
      UserPackageMappingParams params) async {
    try {
      final result = await remoteDataSource.createUserPackageMapping(params);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> updateFamilyMember(
      UpdateMemberParams params) async {
    try {
      final result = await remoteDataSource.updateFamilyMember(params);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ArrayCommonResult>> memberServiceMapping(
      CreateServiceMappingParams params) async {
    try {
      final result = await remoteDataSource.memberServiceMapping(params);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, CouponCodeResult>> codeVerification(
      CouponCodeParams params) async {
    try {
      final result = await remoteDataSource.codeVerification(params);
      if (result.status == true) {
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.message, message: result.message));
      }
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> updateOrders(int id) async {
    try {
      final result = await remoteDataSource.updateOrders(id);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<FamilyMainResult>>> getUserFamilyMapping(
      FamilyQueryParams params) async {
    try {
      final result = await remoteDataSource.getUserFamilyMapping(params);
      if (result != null && result.data != null && result.data.length > 0) {
        return Right(result.data);
      } else {
        return Left(
            AppError(AppErrorType.message, message: 'No family member found.'));
      }
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, RozarPayResult>> createRozarPayOrder(
      int amount) async {
    try {
      final result = await remoteDataSource.createRozarPayOrder(amount);
      return Right(result);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VitalTypeResult>>> getVitalType(
      TypeParams params) async {
    try {
      final result = await remoteDataSource.getVitalType(params);
      if (result != null && result.length > 0) {
        // final data = json.decode(result.toString());
        // List<VitalTypeResult> list = List<VitalTypeResult>.from(data
        //     .map((item) => VitalTypeResult.fromJson({...item, 'show': false})));
        // print('list' + list.toString());
        return Right(result);
      }
      return Left(AppError(AppErrorType.api));
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  // @override
  // Future<Either<AppError, List<VitalTopResult>>> getVitalTypes(
  //     TypeParams params) async {
  //   try {
  //     final result = await remoteDataSource.getVitalTypes(params);
  //     if (result != null && result.length > 0) {
  //       return Right(result);
  //     }
  //     return Left(AppError(AppErrorType.api));
  //   } on SocketException {
  //     return Left(AppError(AppErrorType.network));
  //   } on Exception {
  //     return Left(AppError(AppErrorType.api));
  //   }
  // }
  @override
  Future<Either<AppError, List<List<VitalTypeResult>>>> getVitalTypes(
      TypeParams params) async {
    try {
      final result = await remoteDataSource.getVitalTypes(params);
      if (result != null && result.length > 0) {
        return Right(result);
      }
      return Left(AppError(AppErrorType.api));
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, CouponCodeResult>> codeVerification1(
      CouponCodeParams1 params) async {
    try {
      final result = await remoteDataSource.codeVerification1(params);
      if (result.status == true) {
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.message, message: result.message));
      }
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
