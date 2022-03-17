import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'pruchagePlan_list_event.dart';
part 'purchagePlan_list_state.dart';

class PurchagePlanListBloc
    extends Bloc<PurchagePlanListBlocListEvent, PurchagePlanListState> {
  OtherRemoteDataSource otherDataSource;
  final GetPackage getPackages;
  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  PurchagePlanListBloc({this.otherDataSource, this.getPackages})
      : super(ImmunizationListInitial()) {
    on<GetPackageLists>(
      (event, emit) async {
        emit(ImmunizationLoading());
        FamilyMainResult member =
            await SharedPreferenceHelper.getSelectedFamilyPref();
        try {
          // Either<AppError, List<ImmunizationData>> inv =
          //     await otherDataSource.getImmunization(member.family_member.id);

          final Either<AppError, List<Package>> inv =
              await getPackages(NoParams());
          emit(inv.fold(
            (l) {
              print('left error >>>>>');
              return LoadError(
                errorType: l.appErrorType,
              );
            },
            (r) {
              return Loaded(
                packageList: r,
              );
            },
          ));
        } catch (E) {
          print('no getPackages immmm');
          emit(LoadError(
            errorType: AppErrorType.api,
          ));
        }
      },
      transformer: sequential(),
    );
    on<GetUserFamilyppcount>(
      (event, emit) async {
        User user = await SharedPreferenceHelper.getUserPref();
        if (user != null) {
          Either<AppError, ImmunizationModel> inv =
              await otherDataSource.getUserFamilyppcount(user.id);
          emit(inv.fold(
            (l) {
              print('left error >>>>>');
              return LoadError(
                errorType: l.appErrorType,
              );
            },
            (r) {
              return UserPPLoaded(
                fm_count: r.fm_count,
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

  // @override
  // Stream<PurchagePlanListState> mapEventToState(
  //   PurchagePlanListBlocListEvent event,
  // ) async* {
  //   yield ImmunizationLoading();
  //   if (event is GetPackageLists) {
  //     FamilyMainResult member =
  //         await SharedPreferenceHelper.getSelectedFamilyPref();
  //     try {
  //       // Either<AppError, List<ImmunizationData>> inv =
  //       //     await otherDataSource.getImmunization(member.family_member.id);

  //       final Either<AppError, List<Package>> inv =
  //           await getPackages(NoParams());
  //       yield inv.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return LoadError(
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           return Loaded(
  //             packageList: r,
  //           );
  //         },
  //       );
  //     } catch (E) {
  //       print('no getPackages immmm');
  //       yield LoadError(
  //         errorType: AppErrorType.api,
  //       );
  //     }
  //   } else if (event is GetUserFamilyppcount) {
  //     User user = await SharedPreferenceHelper.getUserPref();
  //     if (user != null) {
  //       Either<AppError, ImmunizationModel> inv =
  //           await otherDataSource.getUserFamilyppcount(user.id);
  //       yield inv.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return LoadError(
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           return UserPPLoaded(
  //             fm_count: r.fm_count,
  //           );
  //         },
  //       );
  //     } else {
  //       print('no dat immmm');
  //       yield LoadError(
  //         errorType: AppErrorType.api,
  //       );
  //     }
  //   }
  // }
}
