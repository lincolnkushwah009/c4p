import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/usecases/user.dart';
import 'package:care4parents/presentation/screens/change_password/model/model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;
  ChangePasswordBloc({@required this.changePassword})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordCurrentPassChanged>(
      (event, emit) async {
        emit(_mapCurrentPassChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ChangePasswordNewPassChanged>(
      (event, emit) async {
        emit(_mapNewPassChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ChangePasswordConfirmPassChanged>(
      (event, emit) async {
        emit(_mapConfirmPassChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<ChangePasswordSubmitted>(
      (event, emit) async {
        await _mapChangePasswordSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<ChangePasswordState> mapEventToState(
  //   ChangePasswordEvent event,
  // ) async* {
  //   if (event is ChangePasswordCurrentPassChanged) {
  //     yield _mapCurrentPassChangedToState(event, state);
  //   } else if (event is ChangePasswordNewPassChanged) {
  //     yield _mapNewPassChangedToState(event, state);
  //   } else if (event is ChangePasswordConfirmPassChanged) {
  //     yield _mapConfirmPassChangedToState(event, state);
  //   } else if (event is ChangePasswordSubmitted) {
  //     yield* _mapChangePasswordSubmittedToState(event, state);
  //   }
  // }

  ChangePasswordState _mapCurrentPassChangedToState(
    ChangePasswordCurrentPassChanged event,
    ChangePasswordState state,
  ) {
    final current_pass = NotEmptyField.dirty(event.current_pass);
    return state.copyWith(
      current_pass: current_pass,
      status:
          Formz.validate([current_pass, state.new_pass, state.confirm_pass]),
    );
  }

  ChangePasswordState _mapNewPassChangedToState(
    ChangePasswordNewPassChanged event,
    ChangePasswordState state,
  ) {
    final new_pass = NotEmptyField.dirty(event.new_pass);
    return state.copyWith(
      new_pass: new_pass,
      status:
          Formz.validate([new_pass, state.current_pass, state.confirm_pass]),
    );
  }

  ChangePasswordState _mapConfirmPassChangedToState(
    ChangePasswordConfirmPassChanged event,
    ChangePasswordState state,
  ) {
    final confirm_pass = NotEmptyField.dirty(event.confirm_pass);
    return state.copyWith(
      confirm_pass: confirm_pass,
      status:
          Formz.validate([confirm_pass, state.new_pass, state.confirm_pass]),
    );
  }

  _mapChangePasswordSubmittedToState(
    ChangePasswordSubmitted event,
    ChangePasswordState state,
    Emitter<ChangePasswordState> emit,
  ) async {
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, UserEntity> eitherResponse =
            await changePassword(UserParams(password: state.new_pass.value));

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
