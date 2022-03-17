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
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/domain/repositories/subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/usecases/usecase.dart';

class GetPackage extends UseCase<List<Package>, NoParams> {
  final SubscriptionRepository repository;

  GetPackage(this.repository);

  @override
  Future<Either<AppError, List<Package>>> call(NoParams noParams) async {
    return await repository.getPackages();
  }
}

class CreateFamilyMember extends UseCase<MemberResultModel, MemberParams> {
  final SubscriptionRepository repository;

  CreateFamilyMember(this.repository);

  @override
  Future<Either<AppError, MemberResultModel>> call(
      MemberParams memberParams) async {
    return await repository.createMember(memberParams);
  }
}

class CreateFamilyMapping
    extends UseCase<ObjectCommonResult, MemberMappingParams> {
  final SubscriptionRepository repository;

  CreateFamilyMapping(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(
      MemberMappingParams params) async {
    return await repository.createFamilyMapping(params);
  }
}

class CreateOrder extends UseCase<OrderResult, OrderParams> {
  final SubscriptionRepository repository;

  CreateOrder(this.repository);

  @override
  Future<Either<AppError, OrderResult>> call(OrderParams params) async {
    return await repository.createOrder(params);
  }
}

class CreateRozerPayOrder extends UseCase<RozarPayResult, int> {
  final SubscriptionRepository repository;

  CreateRozerPayOrder(this.repository);

  @override
  Future<Either<AppError, RozarPayResult>> call(int params) async {
    return await repository.createRozarPayOrder(params);
  }
}

class CreateUserPackageMapping
    extends UseCase<UserPackageMappingResult, UserPackageMappingParams> {
  final SubscriptionRepository repository;

  CreateUserPackageMapping(this.repository);

  @override
  Future<Either<AppError, UserPackageMappingResult>> call(
      UserPackageMappingParams params) async {
    return await repository.createUserPackageMapping(params);
  }
}

class UpdateFamilyMember
    extends UseCase<ObjectCommonResult, UpdateMemberParams> {
  final SubscriptionRepository repository;

  UpdateFamilyMember(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(
      UpdateMemberParams params) async {
    print('params' + params.toJson().toString());
    return await repository.updateFamilyMember(params);
  }
}

class MemberServcieMapping
    extends UseCase<ArrayCommonResult, CreateServiceMappingParams> {
  final SubscriptionRepository repository;

  MemberServcieMapping(this.repository);

  @override
  Future<Either<AppError, ArrayCommonResult>> call(
      CreateServiceMappingParams params) async {
    return await repository.memberServiceMapping(params);
  }
}

class CodeVerification extends UseCase<CouponCodeResult, CouponCodeParams> {
  final SubscriptionRepository repository;

  CodeVerification(this.repository);

  @override
  Future<Either<AppError, CouponCodeResult>> call(
      CouponCodeParams params) async {
    return await repository.codeVerification(params);
  }
}

class CodeVerification1 extends UseCase<CouponCodeResult, CouponCodeParams1> {
  final SubscriptionRepository repository;

  CodeVerification1(this.repository);

  @override
  Future<Either<AppError, CouponCodeResult>> call(
      CouponCodeParams1 params) async {
    return await repository.codeVerification1(params);
  }
}

class UpdateOrders extends UseCase<ObjectCommonResult, int> {
  final SubscriptionRepository repository;

  UpdateOrders(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(int id) async {
    return await repository.updateOrders(id);
  }
}

class GetUserFamilyList
    extends UseCase<List<FamilyMainResult>, FamilyQueryParams> {
  final SubscriptionRepository repository;

  GetUserFamilyList(this.repository);

  @override
  Future<Either<AppError, List<FamilyMainResult>>> call(
      FamilyQueryParams params) async {
    return await repository.getUserFamilyMapping(params);
  }
}

class GetVitalList extends UseCase<List<VitalTypeResult>, TypeParams> {
  final SubscriptionRepository repository;

  GetVitalList(this.repository);

  @override
  Future<Either<AppError, List<VitalTypeResult>>> call(
      TypeParams params) async {
    return await repository.getVitalType(params);
  }
}

// class GetVitalLists extends UseCase<List<VitalTopResult>, TypeParams> {
//   final SubscriptionRepository repository;

//   GetVitalLists(this.repository);

//   @override
//   Future<Either<AppError, List<VitalTopResult>>> call(TypeParams params) async {
//     return await repository.getVitalTypes(params);
//   }
// }
class GetVitalLists extends UseCase<List<List<VitalTypeResult>>, TypeParams> {
  final SubscriptionRepository repository;

  GetVitalLists(this.repository);

  @override
  Future<Either<AppError, List<List<VitalTypeResult>>>> call(
      TypeParams params) async {
    return await repository.getVitalTypes(params);
  }
}
