
import 'package:care4parents/apple_login/apple_sign_in.dart';
import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/social_login_params.dart';

import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:care4parents/domain/usecases/usecase.dart';
import 'package:care4parents/util/internet_check.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

class AppleSigninUsercase extends UseCase<User, NoParams> {
  final AppleSignIn appleSignIn;
  final InternetCheck _internetCheck;
  final AuthenticationRepository repository;
  final ApiClient _client;

  AppleSigninUsercase(
      this.appleSignIn, this._internetCheck, this.repository, this._client);

  final String kSecretKey =
      'vKaP2slE9nieAxM2d0DH1PoktxfuyZl5ym8HM3yDu8s7744yTPBLHb11w3QKJUBm';

  @override
  Future<Either<AppError, User>> call(NoParams params) async {
    try {
      if (await _internetCheck.check()) {
        if (await AppleSignIn.isAvailable()) {
          print('sonu first');
          final AuthorizationResult result = await AppleSignIn.performRequests([
            AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
          ]);

          print('sonu sss>> ' + result.toString());
          switch (result.status) {
            case AuthorizationStatus.authorized:
              print(result.credential.user);

              var appleUser =
                  parseJwt(utf8.decode(result.credential.identityToken));

              print(appleUser['email']);
              print('sonu sss');


              return await repository.socialLogin(SocialLoginParams(

                  name: "",
                  firstName: appleUser['fullName'],
                  lastName: appleUser['fullName'],
                  // photoUrl: response.photoUrl,
                  email: appleUser['email'],
                  authToken: appleUser['c_hash'],
                  // id: response.id,
                  provider: 'APPLE'));

              break; //All the required credentials
            case AuthorizationStatus.error:
              print("Sign in failed: ${result.error.localizedDescription}");
              print('sonu failed');
              return left(
                  AppError(AppErrorType.network, message: 'Sign in failed'));
              break;
            case AuthorizationStatus.cancelled:
              print('User cancelled');
              print('sonu cancelled');
              return left(
                  AppError(AppErrorType.network, message: 'User cancelled'));
              break;
            default:
              throw UnimplementedError();
          }
        }
        // final result = await facebookLogin.logIn(['email']);
        // print('result =======>' + result.toString());
        // switch (result.status) {
        //   case FacebookLoginStatus.loggedIn:
        //     print('result.accessToken.token =========> ' +
        //         result.accessToken.token);

        //     final graphResponse = await _client.getDirect(
        //         'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken.token}');
        //     final response = FbResult.fromJson(graphResponse);
        //     print('graphResponse ========> ' + response.toString());

        //     return await repository.socialLogin(SocialLoginParams(
        //         name: response.name,
        //         firstName: response.first_name,
        //         lastName: response.last_name,
        //         // photoUrl: response.photoUrl,
        //         email: response.email,
        //         authToken: result.accessToken.token,
        //         id: response.id,
        //         provider: 'FACEBOOK'));
        //     break;
        //   case FacebookLoginStatus.cancelledByUser:
        //     return left(
        //         AppError(AppErrorType.message, message: 'Cancelled by user'));
        //     // _showCancelledMessage();
        //     break;
        //   case FacebookLoginStatus.error:
        //     return left(
        //         AppError(AppErrorType.message, message: result.errorMessage));

        //     break;
        // }
        // // print((await userGoogleSignIn.authentication).idToken);
        // // if (userGoogleSignIn != null) {
        // //   return authOnServer(userGoogleSignIn);
        // // } else {
        // //   return left(AppError(AppErrorType.api));
        // // }
        // return null;
      } else {
        return left(AppError(AppErrorType.network));
      }
    } catch (e) {
      print(e);
      return Left(AppError(AppErrorType.database));
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    print(payloadMap);
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
