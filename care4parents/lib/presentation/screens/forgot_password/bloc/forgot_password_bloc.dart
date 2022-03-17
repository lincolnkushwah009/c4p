import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/usecases/auth.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPassword forgotPassword;

  ForgotPasswordBloc({@required this.forgotPassword})
      : super(ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(
      (event, emit) async {
        emit(_mapEmailChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ForgotPasswordSubmitted>(
      (event, emit) async {
        await _mapForgotPasswordSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<ForgotPasswordState> mapEventToState(
  //   ForgotPasswordEvent event,
  // ) async* {
  //   if (event is ForgotPasswordEmailChanged) {
  //     yield _mapEmailChangedToState(event, state);
  //   } else if (event is ForgotPasswordSubmitted) {
  //     yield* _mapForgotPasswordSubmittedToState(event, state);
  //   }
  // }

  ForgotPasswordState _mapEmailChangedToState(
    ForgotPasswordEmailChanged event,
    ForgotPasswordState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  _mapForgotPasswordSubmittedToState(
    ForgotPasswordSubmitted event,
    ForgotPasswordState state,
    Emitter<ForgotPasswordState> emit,
  ) async {
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, CommonResult> eitherResponse =
            await forgotPassword(UserParams(email: state.email.value));
        print('eitherResponse >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error >>>>>');
            return state.copyWith(status: FormzStatus.submissionFailure);
          },
          (r) {
            return state.copyWith(status: FormzStatus.submissionSuccess);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
