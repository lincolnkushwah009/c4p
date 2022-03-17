import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/data/models/user_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/social_login_params.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:dartz/dartz.dart';

const String LOGIN_PATH = 'auth/local';
const String MOBILELOGIN_PATH = 'auth/local/otp';
const String SIGNUP_PATH = 'auth/local/register';
const String FORGOT_PASSWORD_PATH = 'auth/forgot-password';
const String RESET_PASSWORD_PATH = 'auth/password-confirmation';
const String PROFILE_PATH = 'users/me';
const String EDIT_PROFILE_PATH = 'users';
const String CHANGE_PASSWORD_PATH = 'users';
const String CHANGE_PROFILE_PATH = 'document/userprofile';
const String SOCIAL_LOGIN = 'auth/local/sociallogin';
const String CONFIRM_EMAIL = 'users-confirm-email';

abstract class UserRemoteDataSource {
  Future<Either<AppError, User>> login(
      String identifier, String password, String phone_number);

  Future<Either<AppError, User>> signup(String email, String password,
      String username, String name, String phone_number);
  Future<CommonResult> forgotPass(String email);
  Future<User> resetPass(String code);
  Future<User> getUser();
  Future<User> editProfile(UserParams user);
  Future<User> changePassword(UserParams user);
  Future<UserProfileResponse> changeProfile(String path);
  Future<UserProfileResponse> emailVerify(String email);
  Future<User> socialLogin(SocialLoginParams params);
}

class UserRempoteDataSourceImpl extends UserRemoteDataSource {
  final ApiClient _client;
  UserRempoteDataSourceImpl(this._client);

  @override
  Future<Either<AppError, User>> login(
      String identifier, String password, String phone_number) async {
    if (phone_number == "") {
      final response = await _client
          .post(LOGIN_PATH, {'identifier': identifier, 'password': password});
      print('user response main ----------' + response.toString());

      final userRes = UserResult.fromJson(response);
      print('user response ----------' + userRes.toString());

      if (userRes != null && userRes.confirmation == 'success') {
        final token = userRes.jwt;
        await SharedPreferenceHelper.setTokenPref(token);
        await SharedPreferenceHelper.setUserPref(userRes.user);
        return Right(userRes.user);
      }
      return Left(AppError(AppErrorType.api, message: userRes.message));
    } else {
      final response =
          await _client.post(MOBILELOGIN_PATH, {'phone_number': phone_number});
      print('user response main ----------' + response.toString());

      final userRes = UserResult.fromJson(response);
      print('user response ----------' + userRes.toString());

      if (userRes != null && userRes.confirmation == 'success') {
        // final token = userRes.jwt;
        // await SharedPreferenceHelper.setTokenPref(token);
        // await SharedPreferenceHelper.setUserPref(userRes.user);
        return Right(userRes.user);
      }
      return Left(AppError(AppErrorType.api, message: userRes.message));
    }
  }

  @override
  Future<Either<AppError, User>> signup(String email, String password,
      String username, String name, String phone_number) async {
    try {
      final response = await _client.post(SIGNUP_PATH, {
        'email': email,
        'password': password,
        'username': username,
        'name': name,
        'phone_number': phone_number
      });

      print('response signup ---->' + response.toString());

      final userRes = UserResult.fromJson(response);

      if (userRes != null && userRes.confirmation == 'success') {
        final user = userRes?.user;
        final token = userRes?.jwt;
        user.message = userRes.message;
        print(userRes.jwt);
        print(userRes.user);
        if (token != null) {
          await SharedPreferenceHelper.setTokenPref(token);
        }
        if (user != null) {
          await SharedPreferenceHelper.setUserPref(user);
          return Right(user);
        }
        return Left(AppError(AppErrorType.api, message: userRes.message));
      }
      return Left(AppError(AppErrorType.api, message: userRes.message));
    } catch (error) {
      print('error ======' + error);
      return Left(AppError(AppErrorType.api, message: error.message));
    }
  }

  @override
  Future<CommonResult> forgotPass(String email) async {
    final response = await _client.post(FORGOT_PASSWORD_PATH, {
      'email': email,
    });
    if (CommonResult.fromJson(response) != null &&
        CommonResult.fromJson(response).confirmation == 'success') {
      return CommonResult.fromJson(response);
    }
    return null;
  }

  @override
  Future<User> getUser() async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.get(PROFILE_PATH, token);
    final user = User.fromJson(response);
    await SharedPreferenceHelper.setUserPref(user);

    return user;
  }

  @override
  Future<User> editProfile(UserParams userParams) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user_data = await SharedPreferenceHelper.getUserPref();
    final response = await _client.put(EDIT_PROFILE_PATH, token, {
      'email': userParams.email,
      'phone_number': userParams.phone_number,
      'name': userParams.name,
      'country': userParams.country,
      'address': userParams.address
    }, {
      'id': user_data.id.toString()
    });
    final user = User.fromJson(response);
    await SharedPreferenceHelper.setUserPref(user);
    return user;
  }

  @override
  Future<User> resetPass(String code) {
    // TODO: implement resetPass
    throw UnimplementedError();
  }

  @override
  Future<User> changePassword(UserParams userParams) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user_data = await SharedPreferenceHelper.getUserPref();
    final response = await _client.put(CHANGE_PASSWORD_PATH, token,
        {'password': userParams.password}, {'id': user_data.id.toString()});
    final user = User.fromJson(response);
    await SharedPreferenceHelper.setUserPref(user);
    return user;
  }

  @override
  Future<UserProfileResponse> changeProfile(String path) async {
    print('Path========>' + path);
    String token = await SharedPreferenceHelper.getTokenPref();
    final response =
        await _client.postMultiPart(CHANGE_PROFILE_PATH, path, token);
    final result = UserProfileResponse.fromJson(response);
    if (result != null && result.confirmation == 'success') {
      return result;
    }
    return null;
  }

  @override
  Future<UserProfileResponse> emailVerify(String email) async {
    print('email========>' + email);
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.post(CONFIRM_EMAIL, {'email': email}, token);
    print('user response CONFIRM_EMAIL----------' + response.toString());
    final result = UserProfileResponse.fromJson(response);
    if (result != null && result.confirmation == 'success') {
      return result;
    }
    return null;
  }

  @override
  Future<User> socialLogin(SocialLoginParams params) async {
    final response = await _client.post(SOCIAL_LOGIN, {...params.toJson()});
    final result = UserResult.fromJson(response);
    if (result != null && result.confirmation == 'success') {
      print('jwt========' + UserResult.fromJson(response).jwt);
      final user = UserResult.fromJson(response).user;
      final token = UserResult.fromJson(response).jwt;
      await SharedPreferenceHelper.setTokenPref(token);
      await SharedPreferenceHelper.setUserPref(user);
      return user;
    }
    return null;
  }
}
