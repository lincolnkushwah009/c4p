import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/usecases/apple.dart';
import 'package:care4parents/domain/usecases/auth.dart';
import 'package:care4parents/domain/usecases/facebookLogin.dart';
import 'package:care4parents/domain/usecases/google.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final GoogleSignInUsecase googleSignInUsecase;
  final FacebookLoginUsercase facebookLogin;
  final AppleSigninUsercase appleSignInUsercase;

  LoginBloc({
    @required this.login,
    @required this.googleSignInUsecase,
    @required this.facebookLogin,
    @required this.appleSignInUsercase,
  }) : super(LoginState(country_code: NotEmptyField.dirty('91'))) {
    //pj - start
    on<LoginEmailChanged>(
      (event, emit) async {
        emit(_mapEmailChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<LoginPasswordChanged>(
      (event, emit) async {
        emit(_mapPasswordChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<LoginSubmitted>(
      (event, emit) async {
        await _mapLoginSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<LoginmobileChanged>(
      (event, emit) async {
        emit(_mapMobileChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<LoginCodeChanged>(
      (event, emit) async {
        emit(_mapCodeChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignInWithGooglePressed>(
      (event, emit) async {
        await _mapSignInGoogleToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<LoginToFacebook>(
      (event, emit) async {
        await _mapFacebookLoginToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<LoginToApple>(
      (event, emit) async {
        await _mapSignInAppleToState(event, state, emit);
      },
      transformer: sequential(),
    );
    //pj - end
  }

  // @override
  // Stream<LoginState> mapEventToState(
  //   LoginEvent event,
  // ) async* {
  //   if (event is LoginEmailChanged) {
  //     // yield _mapEmailChangedToState(event, state);
  //   } else if (event is LoginPasswordChanged) {
  //     // yield _mapPasswordChangedToState(event, state);
  //   } else if (event is LoginmobileChanged) {
  //     // yield _mapMobileChangedToState(event, state);
  //   } else if (event is LoginCodeChanged) {
  //     // yield _mapCodeChangedToState(event, state);
  //   } else if (event is LoginSubmitted) {
  //     // yield* _mapLoginSubmittedToState(event, state);
  //   } else if (event is SignInWithGooglePressed) {
  //     // yield* _mapSignInGoogleToState(event, state);
  //   } else if (event is LoginToApple) {
  //     // yield* _mapSignInAppleToState(event, state);
  //   } else if (event is LoginToFacebook) {
  //     // yield* _mapFacebookLoginToState(event, state);
  //   }
  // }

  LoginState _mapEmailChangedToState(
    LoginEmailChanged event,
    LoginState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      username: UserName.dirty(''),
      status: Formz.validate([state.password, email]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      username: UserName.dirty(''),
      status: Formz.validate([password, state.email]),
    );
  }

  LoginState _mapCodeChangedToState(
    LoginCodeChanged event,
    LoginState state,
  ) {
    final country_code = NotEmptyField.dirty(event.country_code);
    print('country_code ========= testing   ====================' +
        country_code.value);
    return state.copyWith(
      country_code: country_code,
      // email: Email.dirty(''),
      // password: Password.dirty(''),
      status: Formz.validate([
        country_code,
        state.username,
      ]),
    );
  }

  LoginState _mapMobileChangedToState(
    LoginmobileChanged event,
    LoginState state,
  ) {
    final username = UserName.dirty(event.username);
    // final email = Email.dirty('');
    print('phone number--------' + username.toString());
    print(state.email.value);
    print(state.password.value);
    return state.copyWith(
      username: username,
      password: Password.dirty(''),
      email: Email.dirty(''),
      status: Formz.validate([
        state.country_code,
        username,
      ]),
      // email: email,
      // password: Password.dirty(''),
    );
  }

  _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
    Emitter<LoginState> emit,
  ) async {
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        if (state.username.value != "") {
          print('username >>>>>>' + state.username.value.toString());
          final Either<AppError, UserEntity> eitherResponse =
              await login(UserParams(
            email: state.email.value,
            password: state.password.value,
            phone_number: '${state.country_code.value}${state.username.value}',
          ));

          print('eitherResponse >>>>>>' + eitherResponse.toString());
          emit(eitherResponse.fold(
            (l) {
              print('left error >>>>>');
              print(l.message);
              return state.copyWith(
                  status: FormzStatus.submissionFailure, error: l.message);
            },
            (r) {
              return state.copyWith(status: FormzStatus.submissionSuccess);
            },
          ));
        } else {
          print('email >>>>>>' + state.email.value.toString());

          print('password >>>>>>' + state.password.value.toString());

          final Either<AppError, UserEntity> eitherResponse =
              await login(UserParams(
            email: state.email.value,
            password: state.password.value,
            phone_number: state.username.value,
          ));
          print('eitherResponse >>>>>>' + eitherResponse.toString());
          emit(eitherResponse.fold(
            (l) {
              print('left error >>>>>');
              print(l.message);
              return state.copyWith(
                  status: FormzStatus.submissionFailure, error: l.message);
            },
            (r) {
              return state.copyWith(status: FormzStatus.submissionSuccess);
            },
          ));
        }
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  _mapSignInGoogleToState(
    SignInWithGooglePressed event,
    LoginState state,
    Emitter<LoginState> emit,
  ) async {
    try {
      final Either<AppError, User> eitherResponse =
          await googleSignInUsecase(NoParams());
      print('eitherResponse >>>>>> 1' + eitherResponse.toString());

      emit(eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          return state.copyWith(status: FormzStatus.submissionFailure);
        },
        (r) {
          return state.copyWith(
              status: FormzStatus.submissionSuccess,
              email: Email.dirty(r.email),
              username: UserName.dirty(r.username));
        },
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  _mapFacebookLoginToState(
    LoginToFacebook event,
    LoginState state,
    Emitter<LoginState> emit,
  ) async {
    try {
      final Either<AppError, User> eitherResponse =
          await facebookLogin(NoParams());
      print('eitherResponse >>>>>>' + eitherResponse.toString());
      emit(eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          return state.copyWith(status: FormzStatus.submissionFailure);
        },
        (r) {
          return state.copyWith(
              status: FormzStatus.submissionSuccess,
              email: Email.dirty(r.email),
              username: UserName.dirty(r.username));
        },
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  _mapSignInAppleToState(
    LoginToApple event,
    LoginState state,
    Emitter<LoginState> emit,
  ) async {
    try {
      final Either<AppError, User> eitherResponse =
          await appleSignInUsercase(NoParams());
      print('eitherResponse >>>>>>' + eitherResponse.toString());
      emit(eitherResponse.fold((l) {
        print('left error >>>>>');
        return state.copyWith(
            status: FormzStatus.submissionFailure, error: l.message);
      }, (r) {
        return state.copyWith(status: FormzStatus.submissionSuccess);
      }));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, error: _.toString()));
    }
  }
}
