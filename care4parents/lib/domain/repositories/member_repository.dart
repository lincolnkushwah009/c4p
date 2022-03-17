import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:dartz/dartz.dart';

abstract class MemberRepository {
  Future<Either<AppError, ObjectCommonResult>> familyOtp(String phone);
  Future<Either<AppError, FamilyMember>> familyOtpVerification(
      String phone, String otp,String phoneWithoutContrycode,String type);
}
