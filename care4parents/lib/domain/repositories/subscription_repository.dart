import 'package:care4parents/data/models/array_common_result.dart';
import 'package:care4parents/data/models/coupon_code_result.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/member_result.dart';
import 'package:care4parents/data/models/member_service_mapping_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/order_result.dart';
import 'package:care4parents/data/models/rozar_pay_result.dart';
import 'package:care4parents/data/models/update_family_member_result.dart';
import 'package:care4parents/data/models/user_family_main_result.dart';
import 'package:care4parents/data/models/user_package_mapping_result.dart';
import 'package:care4parents/data/models/vital_top_result.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:dartz/dartz.dart';

abstract class SubscriptionRepository {
  Future<Either<AppError, List<Package>>> getPackages();
  Future<Either<AppError, MemberResultModel>> createMember(
      MemberParams memberParams);
  Future<Either<AppError, ObjectCommonResult>> createFamilyMapping(
      MemberMappingParams params);
  Future<Either<AppError, OrderResult>> createOrder(OrderParams params);
  Future<Either<AppError, UserPackageMappingResult>> createUserPackageMapping(
      UserPackageMappingParams params);
  Future<Either<AppError, ObjectCommonResult>> updateFamilyMember(
      UpdateMemberParams params);
  Future<Either<AppError, ArrayCommonResult>> memberServiceMapping(
      CreateServiceMappingParams params);
  Future<Either<AppError, CouponCodeResult>> codeVerification(
      CouponCodeParams params);
  Future<Either<AppError, CouponCodeResult>> codeVerification1(
      CouponCodeParams1 params);
  Future<Either<AppError, ObjectCommonResult>> updateOrders(int id);
  Future<Either<AppError, RozarPayResult>> createRozarPayOrder(int amount);
  Future<Either<AppError, List<FamilyMainResult>>> getUserFamilyMapping(
      FamilyQueryParams params);
  Future<Either<AppError, List<VitalTypeResult>>> getVitalType(
      TypeParams params);
  // Future<Either<AppError, List<VitalTopResult>>> getVitalTypes(
  //     TypeParams params);
  Future<Either<AppError, List<List<VitalTypeResult>>>> getVitalTypes(
      TypeParams params);
}
