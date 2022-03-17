import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/usecases/member.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final Otp phoneSubmit;
  final OtpVerify otpVerify;

  MemberBloc({@required this.phoneSubmit, @required this.otpVerify})
      : super(MemberState(country_code: NotEmptyField.dirty('91'))) {
    on<MemberPhoneNumberChanged>(
      (event, emit) async {
        emit(_mapPhoneNumberChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<MemberOtpChanged>(
      (event, emit) async {
        emit(_mapOtpChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<MemberCodeChanged>(
      (event, emit) async {
        emit(_mapCodeChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<MemberPhoneSubmit>(
      (event, emit) async {
        await _mapMemberSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<MemberOtpSubmit>(
      (event, emit) async {
        await _mapPhoneSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<MemberTypeChanged>(
      (event, emit) async {
        emit(_mapTypeChangedToState(event, state));
      },
      transformer: sequential(),
    );
  }

  @override
  Stream<MemberState> mapEventToState(
    MemberEvent event,
  ) async* {
    if (event is MemberPhoneNumberChanged) {
      // yield _mapPhoneNumberChangedToState(event, state);
    } else if (event is MemberOtpChanged) {
      // yield _mapOtpChangedToState(event, state);
    } else if (event is MemberCodeChanged) {
      // yield _mapCodeChangedToState(event, state);
    } else if (event is MemberPhoneSubmit) {
      // yield* _mapMemberSubmittedToState(event, state);
    } else if (event is MemberOtpSubmit) {
      // yield* _mapPhoneSubmittedToState(event, state);
    } else if (event is MemberTypeChanged) {
      yield _mapTypeChangedToState(event, state);
    }
  }

  MemberState _mapTypeChangedToState(
    MemberTypeChanged event,
    MemberState state,
  ) {
    final type = NotEmptyField.dirty(event.type);
    print('type' + type.toString());
    return state.copyWith(
      type: type,
    );
  }

  MemberState _mapPhoneNumberChangedToState(
    MemberPhoneNumberChanged event,
    MemberState state,
  ) {
    final phone = PhoneNumber.dirty(event.phone);
    print('phone' + phone.toString());
    return state.copyWith(
      phone: phone,
      status: Formz.validate([phone]),
    );
  }

  MemberState _mapCodeChangedToState(
    MemberCodeChanged event,
    MemberState state,
  ) {
    final country_code = NotEmptyField.dirty(event.country_code);
    print('country_code ========= testing   ====================' +
        country_code.value);
    print('state.phone ========= testing   ====================' +
        state.phone.value);
    return state.copyWith(
      country_code: country_code,
      status: Formz.validate([country_code, state.phone]),
    );
  }

  MemberState _mapOtpChangedToState(
    MemberOtpChanged event,
    MemberState state,
  ) {
    final otp = NotEmptyField.dirty(event.otp);
    return state.copyWith(
      otp: otp,
      status1: Formz.validate([otp, state.phone, state.country_code]),
    );
  }

  _mapMemberSubmittedToState(
    MemberPhoneSubmit event,
    MemberState state,
    Emitter<MemberState> emit,
  ) async {
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, ObjectCommonResult> eitherResponse =
            await phoneSubmit(
                '${state.country_code.value}${state.phone.value}');
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

  _mapPhoneSubmittedToState(
    MemberOtpSubmit event,
    MemberState state,
    Emitter<MemberState> emit,
  ) async {
    print(state.status1.isValidated);
    if (state.status1.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        print('phone ' +
            state.phone.value +
            'otp ' +
            state.otp.value +
            ' type ' +
            state.type.value);
        final Either<AppError, FamilyMember> eitherResponse = await otpVerify(
            FamilyMemberParams(
                phone: '${state.country_code.value}${state.phone.value}',
                otp: state.otp.value,
                phoneWithoutContrycode: state.phone.value,
                type: state.type.value));
        print('eitherResponse phoneSubmit>>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error phoneSubmit>>>>>');
            return state.copyWith(status1: FormzStatus.submissionFailure);
          },
          (r) {
            print('right error sonu>>>>>');
            return state.copyWith(status1: FormzStatus.submissionSuccess);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status1: FormzStatus.submissionFailure));
      }
    }
  }
}
