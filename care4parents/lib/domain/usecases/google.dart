import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/data/models/user_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/social_login_params.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:care4parents/domain/usecases/usecase.dart';
import 'package:care4parents/util/internet_check.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase extends UseCase<User, NoParams> {
  final GoogleSignIn _googleSignIn;
  final InternetCheck _internetCheck;
  final AuthenticationRepository repository;

  GoogleSignInUsecase(this._googleSignIn, this._internetCheck, this.repository);

  Future<Either<AppError, User>> authOnServer(
      GoogleSignInAccount account) async {
    final authData = await account.authentication;

    return await repository.socialLogin(SocialLoginParams(
        name: account.displayName,
        firstName: account.displayName.split(' ')[0],
        lastName: account.displayName.split(' ')[1],
        photoUrl: account.photoUrl,
        email: account.email,
        authToken: authData.accessToken,
        idToken: authData.idToken,
        provider: 'GOOGLE'));
  }

  @override
  Future<Either<AppError, User>> call(NoParams params) async {
    try {
      if (await _internetCheck.check()) {
        final userGoogleSignIn = await _googleSignIn.signIn();
        // print('userGoogleSignIn' + userGoogleSignIn.email);

        print((await userGoogleSignIn.authentication).idToken);
        if (userGoogleSignIn != null) {
          return authOnServer(userGoogleSignIn);
        } else {
          return left(AppError(AppErrorType.api));
        }
      } else {
        return left(AppError(AppErrorType.network));
      }
    } catch (e) {
      print(e);
      return Left(AppError(AppErrorType.database));
    }
  }

  // Future<String> generateTokenFromGoogleIdToken(String idToken) async {
  //   final jwt = JsonWebToken.unverified(idToken);

  //   final builder = new JsonWebSignatureBuilder();

  //   // set the content
  //   builder.jsonContent = jwt.claims;

  //   // add a key to sign, can only add one for JWT
  //   builder.addRecipient(
  //     JsonWebKey.fromJson({
  //       'kty': 'oct',
  //       'k': kSecretKey,
  //     }),
  //     algorithm: "HS256",
  //   );

  //   // build the jws
  //   var jws = builder.build();
  //   return jws.toCompactSerialization();
  // }
}
