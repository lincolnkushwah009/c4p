import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/family_member_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user_result.dart';
import 'package:care4parents/helper/shared_preferences.dart';

const String FAMILY_MEMER_OTP = 'family-members/otp';
const String FAMILY_MEMER_OTP_VERIFY = 'family-members/otpverify';
const String LOGIN_OTP_VERIFY = 'auth/local/verify-otp';

abstract class MemberRemoteDataSource {
  Future<ObjectCommonResult> familyOtp(String phone);
  Future<FamilyMember> familyOtpVerification(String phone, String otp,String phoneWithoutContrycode,String type);
  // Future<FamilyMember> memberActivity(String phone, String otp);
}

class MemberRemoteDataSourceImpl extends MemberRemoteDataSource {
  final ApiClient _client;
  MemberRemoteDataSourceImpl(this._client);
  @override
  Future<ObjectCommonResult> familyOtp(String phone) async {
    final response = await _client.post(FAMILY_MEMER_OTP, {"phone": '$phone'});
    print('response>>>>>>>>>>>> familyOtp' + response.toString());
    return ObjectCommonResult.fromJson(response);
  }

  @override
  Future<FamilyMember> familyOtpVerification(String phone, String otp,String phoneWithoutContrycode,String type) async {

    if(type=='member'){

    final response = await _client
        .post(FAMILY_MEMER_OTP_VERIFY, {"phone": '$phone', "otp": '$otp'});
    print('response>>>>>>>>>>>> familyOtpVerification' + response.toString());

    final member = FamilyMemberResult.fromJson(response).data;
    final newMember = FamilyMember.fromJson({
      'id': member.id,
      "email": member.email,
      "name": member.name,
      "dob": member.dob,
      "gender": member.gender,
      "age": 0,
      'phone': phoneWithoutContrycode
    });

    final token = FamilyMemberResult.fromJson(response).token;
    await SharedPreferenceHelper.setFamilyPref(newMember);
    await SharedPreferenceHelper.setTokenPref(token);
    return member;
  }else{
      final response = await _client
          .post(LOGIN_OTP_VERIFY, {"phone_number": '$phone', "otp": '$otp'});
      print('response>>>>>>>>>>>> LOGIN_OTP_VERIFY' + response.toString());

      final userRes = UserResult.fromJson(response);
      print('user response ----------' + userRes.toString());
      final member = FamilyMemberResult.fromJson(response).data;
      if (userRes != null && userRes.confirmation == 'success') {
        final token = userRes.jwt;
        await SharedPreferenceHelper.setTokenPref(token);
        await SharedPreferenceHelper.setUserPref(userRes.user);

      }
      final newMember = FamilyMember.fromJson({
        'id':1,
        "email": userRes.confirmation,
        "name":userRes. message,
        "dob": "member.dob",
        "gender": "member.gender",
        "age": 10000,
        'phone': phoneWithoutContrycode
      });

      return newMember;
    }


  }
}
