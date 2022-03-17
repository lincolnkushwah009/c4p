import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/domain/usecases/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser getUser;
  final _loadingController = StreamController<bool>();

  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  ProfileBloc({this.getUser}) : super(ProfileInitial()) {
    on<GetProfile>(
      (event, emit) async {
        emit(ProfileLoading());
        print('event is GetProfile');
        Either<AppError, UserEntity> userEither = await getUser(NoParams());
        print('userEither' + userEither.toString());
        emit(userEither.fold(
          (l) => ProfileLoadError(
            errorType: l.appErrorType,
          ),
          (user) {
            return ProfileLoaded(
              user: user,
            );
          },
        ));
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<ProfileState> mapEventToState(
  //   ProfileEvent event,
  // ) async* {
  //   yield ProfileLoading();
  //   if (event is GetProfile) {
  //     print('event is GetProfile');
  //     Either<AppError, UserEntity> userEither = await getUser(NoParams());
  //     print('userEither' + userEither.toString());
  //     yield userEither.fold(
  //       (l) => ProfileLoadError(
  //         errorType: l.appErrorType,
  //       ),
  //       (user) {
  //         return ProfileLoaded(
  //           user: user,
  //         );
  //       },
  //     );
  //   }
  // }

  dispose() {
    _loadingController.close();
  }
}
