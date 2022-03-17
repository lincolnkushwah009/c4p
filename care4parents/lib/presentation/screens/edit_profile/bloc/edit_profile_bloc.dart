import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/user_profile_response.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/entities/user_params.dart';
import 'package:care4parents/domain/usecases/user.dart';
import 'package:care4parents/helper/validation/users.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfile editProfile;
  final ChangeProfile changeProfile;
  final EmailVerify emailVerify;

  EditProfileBloc(
      {@required this.editProfile,
      @required this.changeProfile,
      @required this.emailVerify})
      : super(EditProfileState()) {
    on<EditProfileLoadEvent>(
      (event, emit) async {
        emit(_mapChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfileEmailChanged>(
      (event, emit) async {
        emit(_mapEmailChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfileNameChanged>(
      (event, emit) async {
        emit(_mapNameChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfilePhoneNumberChanged>(
      (event, emit) async {
        emit(_mapPhoneNumberChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfileCountry>(
      (event, emit) async {
        emit(_mapCountryChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfileAddress>(
      (event, emit) async {
        emit(_mapAddressChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EditProfileSubmitted>(
      (event, emit) async {
        await _mapEditProfileSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<ProfileImage>(
      (event, emit) async {
        await _mapEditProfileImageSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<ProfileChanged>(
      (event, emit) async {
        emit(_mapImageChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<EmailVerifySubmitted>(
      (event, emit) async {
        await _mapEmailVerifySubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<EditProfileEmailVerifyChanged>(
      (event, emit) async {
        emit(_mapEmailVerifyToState(event, state));
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<EditProfileState> mapEventToState(
  //   EditProfileEvent event,
  // ) async* {
  //   if (event is EditProfileLoadEvent) {
  //     // yield _mapChangedToState(event, state);
  //   } else if (event is EditProfileEmailChanged) {
  //     // yield _mapEmailChangedToState(event, state);
  //   } else if (event is EditProfileNameChanged) {
  //     // yield _mapNameChangedToState(event, state);
  //   } else if (event is EditProfilePhoneNumberChanged) {
  //     // yield _mapPhoneNumberChangedToState(event, state);
  //   } else if (event is EditProfileCountry) {
  //     // yield _mapCountryChangedToState(event, state);
  //   } else if (event is EditProfileAddress) {
  //     // yield _mapAddressChangedToState(event, state);
  //   } else if (event is EditProfileSubmitted) {
  //     // yield* _mapEditProfileSubmittedToState(event, state);
  //   } else if (event is ProfileImage) {
  //     // yield* _mapEditProfileImageSubmittedToState(event, state);
  //   } else if (event is ProfileChanged) {
  //     // yield _mapImageChangedToState(event, state);
  //   } else if (event is EmailVerifySubmitted) {
  //     // yield* _mapEmailVerifySubmittedToState(event, state);
  //   } else if (event is EditProfileEmailVerifyChanged) {
  //     // yield _mapEmailVerifyToState(event, state);
  //   }
  // }

  EditProfileState _mapChangedToState(
    EditProfileLoadEvent event,
    EditProfileState state,
  ) {
    final email = Email.dirty(event.email);
    final name = Name.dirty(event.name);
    final phone_number = PhoneNumber.dirty(event.phone_number);
    final address = Address.dirty(event.address);
    final country = Country.dirty(event.country);
    return state.copyWith(
      email: email,
      name: name,
      phone_number: phone_number,
      address: address,
      country: country,
      status: Formz.validate([
        email,
        phone_number,
        name,
      ]),
    );
  }

  EditProfileState _mapEmailChangedToState(
    EditProfileEmailChanged event,
    EditProfileState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.phone_number,
        state.name,
        state.address,
        state.country
      ]),
    );
  }

  EditProfileState _mapCountryChangedToState(
    EditProfileCountry event,
    EditProfileState state,
  ) {
    final country = Country.dirty(event.country);
    return state.copyWith(
      country: country,
      status: Formz.validate([
        country,
        state.address,
        state.email,
        state.phone_number,
        state.name,
      ]),
    );
  }

  EditProfileState _mapImageChangedToState(
    ProfileChanged event,
    EditProfileState state,
  ) {
    print('_mapImageChangedToState path ' + event.image.path);
    return state.copyWith(
      image: event.image,
    );
  }

  EditProfileState _mapAddressChangedToState(
    EditProfileAddress event,
    EditProfileState state,
  ) {
    final address = Address.dirty(event.address);
    return state.copyWith(
      address: address,
      status: Formz.validate([
        address,
        state.country,
        state.email,
        state.phone_number,
        state.name,
      ]),
    );
  }

  EditProfileState _mapNameChangedToState(
    EditProfileNameChanged event,
    EditProfileState state,
  ) {
    final name = Name.dirty(event.name);
    print('name' + name.toString());
    return state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.phone_number,
        state.address,
        state.country
      ]),
    );
  }

  EditProfileState _mapEmailVerifyToState(
    EditProfileEmailVerifyChanged event,
    EditProfileState state,
  ) {
    final emailVerifyStatus = Name.dirty(event.emailVerifyStatus);
    print('emailVerifyStatus' + emailVerifyStatus.toString());
    return state.copyWith(
      emailVerifyStatus: emailVerifyStatus,
    );
  }

  EditProfileState _mapPhoneNumberChangedToState(
    EditProfilePhoneNumberChanged event,
    EditProfileState state,
  ) {
    final phone_number = PhoneNumber.dirty(event.phone_number);
    return state.copyWith(
      phone_number: phone_number,
      status: Formz.validate([phone_number, state.name, state.email]),
    );
  }

  _mapEmailVerifySubmittedToState(
    EmailVerifySubmitted event,
    EditProfileState state,
    Emitter<EditProfileState> emit,
  ) async {
    print('state.country>>  ' + state.toString());
    print(state.status.isValidated.toString());
    if (true) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, UserProfileResponse> eitherResponse =
            await emailVerify(
          state.email.value,
        );

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

  _mapEditProfileSubmittedToState(
    EditProfileSubmitted event,
    EditProfileState state,
    Emitter<EditProfileState> emit,
  ) async {
    print('state.country' + state.toString());
    print(state.status.isValidated.toString());
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final Either<AppError, UserEntity> eitherResponse =
            await editProfile(UserParams(
          email: state.email.value,
          name: state.name.value,
          phone_number: state.phone_number.value,
          country: state.country.value,
          address: state.address.value,
        ));

        print('eitherResponse >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error >>>>>');
            return state.copyWith(status: FormzStatus.submissionFailure);
          },
          (r) {
            return state.copyWith(
                status: FormzStatus.submissionSuccess,
                emailVerifyStatus: Name.dirty('2'));
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  _mapEditProfileImageSubmittedToState(
    ProfileImage event,
    EditProfileState state,
    Emitter<EditProfileState> emit,
  ) async {
    // if (state.status.isValidated) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final Either<AppError, UserProfileResponse> eitherResponse =
          await changeProfile(event.file.path);

      print('eitherResponse >>>>>>' + eitherResponse.toString());
      emit(eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          return state.copyWith(profile_status: FormzStatus.submissionFailure);
        },
        (r) {
          return state.copyWith(profile_status: FormzStatus.submissionSuccess);
        },
      ));
    } on Exception catch (_) {
      emit(state.copyWith(profile_status: FormzStatus.submissionFailure));
    }
  }

  // }
}
