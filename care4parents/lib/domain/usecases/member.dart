import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/repositories/member_repository.dart';
import 'package:care4parents/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class Otp extends UseCase<ObjectCommonResult, String> {
  final MemberRepository repository;

  Otp(this.repository);

  @override
  Future<Either<AppError, ObjectCommonResult>> call(String phone) async {
    return await repository.familyOtp(phone);
  }
}


class OtpVerify extends UseCase<FamilyMember, FamilyMemberParams> {
  final MemberRepository repository;

  OtpVerify(this.repository);

  @override
  Future<Either<AppError, FamilyMember>> call(FamilyMemberParams params) async {
    return await repository.familyOtpVerification(params.phone, params.otp,params.phoneWithoutContrycode,params.type);
  }
}
