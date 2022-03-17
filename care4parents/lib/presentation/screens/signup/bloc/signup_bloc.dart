import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/usecases/auth.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:care4parents/presentation/screens/signup/models/models.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final Signup signup;

  SignupBloc({@required this.signup})
      : super(SignupState(country_code: NotEmptyField.dirty('91'))) {
    on<SignupEmailChanged>(
      (event, emit) async {
        emit(_mapEmailChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignupPasswordChanged>(
      (event, emit) async {
        emit(_mapPasswordChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignupNameChanged>(
      (event, emit) async {
        emit(_mapNameChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignupUserNameChanged>(
      (event, emit) async {
        emit(_mapUserNameChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignupCodeChanged>(
      (event, emit) async {
        emit(_mapCodeChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<SignupSubmitted>(
      (event, emit) async {
        await _mapSignupSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<SignupState> mapEventToState(
  //   SignupEvent event,
  // ) async* {
  //   if (event is SignupEmailChanged) {
  //     // yield _mapEmailChangedToState(event, state);
  //   } else if (event is SignupPasswordChanged) {
  //     // yield _mapPasswordChangedToState(event, state);
  //   } else if (event is SignupNameChanged) {
  //     // yield _mapNameChangedToState(event, state);
  //   } else if (event is SignupUserNameChanged) {
  //     // yield _mapUserNameChangedToState(event, state);
  //   } else if (event is SignupCodeChanged) {
  //     // yield _mapCodeChangedToState(event, state);
  //   } else if (event is SignupSubmitted) {
  //     yield* _mapSignupSubmittedToState(event, state);
  //   }
  // }

  SignupState _mapEmailChangedToState(
    SignupEmailChanged event,
    SignupState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        state.password,
        email,
        state.username,
        state.name,
        state.country_code
      ]),
    );
  }

  SignupState _mapCodeChangedToState(
    SignupCodeChanged event,
    SignupState state,
  ) {
    final country_code = NotEmptyField.dirty(event.country_code);
    print('country_code ========= testing   ====================' +
        country_code.value);
    return state.copyWith(
      country_code: country_code,
      status: Formz.validate([
        country_code,
        state.password,
        state.email,
        state.username,
        state.name
      ]),
    );
  }

  SignupState _mapPasswordChangedToState(
    SignupPasswordChanged event,
    SignupState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
        state.username,
        state.name,
        state.country_code
      ]),
    );
  }

  SignupState _mapNameChangedToState(
    SignupNameChanged event,
    SignupState state,
  ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.password,
        state.username,
        state.country_code
      ]),
    );
  }

  SignupState _mapUserNameChangedToState(
    SignupUserNameChanged event,
    SignupState state,
  ) {
    final username = UserName.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.name,
        state.email,
        state.password,
        state.country_code
      ]),
    );
  }

  _mapSignupSubmittedToState(SignupSubmitted event, SignupState state,
      Emitter<SignupState> emit) async {
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, UserEntity> eitherResponse =
            await signup(UserParams(
          email: state.email.value,
          password: state.password.value,
          name: state.name.value,
          username: state.name.value,
          phone_number: '${state.country_code.value}${state.username.value}',
        ));

        print('eitherResponse signup >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print(l.message);
            return state.copyWith(
                status: FormzStatus.submissionFailure, error: l.message);
          },
          (r) {
            return state.copyWith(
                status: FormzStatus.submissionSuccess, error: r.message);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, error: _.toString()));
      }
    }
  }
}
