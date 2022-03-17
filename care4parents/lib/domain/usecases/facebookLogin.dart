import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/fb_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/social_login_params.dart';
import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:care4parents/domain/usecases/usecase.dart';
import 'package:care4parents/util/internet_check.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookLoginUsercase extends UseCase<User, NoParams> {
  final FacebookLogin facebookLogin;
  final InternetCheck _internetCheck;
  final AuthenticationRepository repository;
  final ApiClient _client;

  FacebookLoginUsercase(
      this.facebookLogin, this._internetCheck, this.repository, this._client);

  // final String kSecretKey =
  //     'vKaP2slE9nieAxM2d0DH1PoktxfuyZl5ym8HM3yDu8s7744yTPBLHb11w3QKJUBm';

  @override
  Future<Either<AppError, User>> call(NoParams params) async {
    try {
      if (await _internetCheck.check()) {
        final res = await facebookLogin.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);

// Check result status
        switch (res.status) {
          case FacebookLoginStatus.success:
            // Logged in

            // Send access token to server for validation and auth
            final FacebookAccessToken accessToken = res.accessToken;
            print('Access token: ${accessToken.token}');

            // Get profile data
            final profile = await facebookLogin.getUserProfile();
            print('Hello, ${profile.name}! You ID: ${profile.userId}');

            // Get user profile image url
            final imageUrl = await facebookLogin.getProfileImageUrl(width: 100);
            print('Your profile image: $imageUrl');

            // Get email (since we request email permission)
            final email = await facebookLogin.getUserEmail();
            // But user can decline permission
            if (email != null) print('And your email is $email');
            final graphResponse = await _client.getDirect(
                'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken.token}');
            final response = FbResult.fromJson(graphResponse);
            print('graphResponse ========> ' + response.toString());

            return await repository.socialLogin(SocialLoginParams(
                name: response.name,
                firstName: response.first_name,
                lastName: response.last_name,
                photoUrl: imageUrl,
                email: response.email,
                authToken: accessToken.token,
                id: response.id,
                provider: 'FACEBOOK'));

            break;
          case FacebookLoginStatus.cancel:
            // User cancel log in
            return left(
                AppError(AppErrorType.message, message: 'Cancelled by user'));
            break;
          case FacebookLoginStatus.error:
            // Log in failed
            print('Error while log in: ${res.error}');
            return left(
                AppError(AppErrorType.message, message: res.error.toString()));
            break;
        }

        // facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;

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
        // print((await userGoogleSignIn.authentication).idToken);
        // if (userGoogleSignIn != null) {
        //   return authOnServer(userGoogleSignIn);
        // } else {
        //   return left(AppError(AppErrorType.api));
        // }
        return null;
      } else {
        return left(AppError(AppErrorType.network));
      }
    } catch (e) {
      print(e);
      return Left(AppError(AppErrorType.database));
    }
  }
}
