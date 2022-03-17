import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

part 'immunization_list_event.dart';
part 'immunization_list_state.dart';

class ImmunizationListBloc
    extends Bloc<ImmunizationListBlocListEvent, ImmunizationListState> {
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  ImmunizationListBloc({this.otherDataSource})
      : super(ImmunizationListInitial()) {
    on<GetImmunization>(
      (event, emit) async {
        emit(ImmunizationLoading());
        FamilyMainResult member =
            await SharedPreferenceHelper.getSelectedFamilyPref();
        if (member != null) {
          Either<AppError, List<ImmunizationData>> inv =
              await otherDataSource.getImmunization(member.family_member.id);
          emit(inv.fold(
            (l) {
              print('left error >>>>>');
              return LoadError(
                errorType: l.appErrorType,
              );
            },
            (r) {
              return Loaded(
                invoices: r,
              );
            },
          ));
        } else {
          print('no dat immmm');
          emit(LoadError(
            errorType: AppErrorType.api,
          ));
        }
      },
      transformer: sequential(),
    );
  }

  @override
  Stream<ImmunizationListState> mapEventToState(
    ImmunizationListBlocListEvent event,
  ) async* {
    // if (event is GetImmunization) {
    //   yield ImmunizationLoading();
    //   FamilyMainResult member =
    //       await SharedPreferenceHelper.getSelectedFamilyPref();
    //   if (member != null) {
    //     Either<AppError, List<ImmunizationData>> inv =
    //         await otherDataSource.getImmunization(member.family_member.id);
    //     yield inv.fold(
    //       (l) {
    //         print('left error >>>>>');
    //         return LoadError(
    //           errorType: l.appErrorType,
    //         );
    //       },
    //       (r) {
    //         return Loaded(
    //           invoices: r,
    //         );
    //       },
    //     );
    //   } else {
    //     print('no dat immmm');
    //     yield LoadError(
    //       errorType: AppErrorType.api,
    //     );
    //   }
    // }
    // else if (event is GetUserFamilyppcount) {
    //   yield ImmunizationLoading();
    //   User user = await SharedPreferenceHelper.getUserPref();
    //   if (user != null) {
    //     Either<AppError, ImmunizationModel> inv =
    //         await otherDataSource.getUserFamilyppcount(user.id);
    //     yield inv.fold(
    //       (l) {
    //         print('left error >>>>>');
    //         return state.copyWith(status: FormzStatus.submissionFailure);
    //       },
    //       (r) {
    //         // return UserPPLoaded(
    //         //   fm_count: r.fm_count,
    //         // );
    //
    //         return state.copyWith(status: FormzStatus.submissionSuccess,fm_counts:NotEmptyField.dirty(r.fm_count) );
    //
    //       },
    //     );
    //   } else {
    //     print('no dat immmm');
    //     yield   state.copyWith(status: FormzStatus.submissionFailure);
    //   }
    // }
    // else if (event is GetuserSos) {
    //   User user = await SharedPreferenceHelper.getUserPref();
    //   if (user != null) {
    //     Either<AppError, ObjectCommonResult> inv =
    //         await otherDataSource.userSos(user);
    //     yield inv.fold(
    //       (l) {
    //         print('left error >>>>>');
    //         return state.copyWith(status: FormzStatus.submissionFailure);
    //       },
    //       (r) {
    //         return state.copyWith(status: FormzStatus.submissionSuccess,msg:NotEmptyField.dirty(r.message) );
    //       },
    //     );
    //   } else {
    //     print('no dat immmm');
    //     yield state.copyWith(status: FormzStatus.submissionFailure);
    //     ;
    //   }
    // }
  }
}
