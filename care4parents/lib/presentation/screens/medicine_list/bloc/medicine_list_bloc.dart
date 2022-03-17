import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'medicine_list_event.dart';
part 'medicine_list_state.dart';

class MedicineListBloc extends Bloc<MedicineListEvent, MedicineListState> {
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  MedicineListBloc({this.otherDataSource}) : super(MedicineListInitial()) {
    on<GetMedicine>(
      (event, emit) async {
        emit(MedicineLoading());
        FamilyMainResult member =
            await SharedPreferenceHelper.getSelectedFamilyPref();
        if (member != null) {
          Either<AppError, List<MedicineData>> inv =
              await otherDataSource.getMedicine(member.family_member.id);
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
          print('no dat medicine member');
          emit(LoadError(
            errorType: AppErrorType.api,
          ));
        }
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<MedicineListState> mapEventToState(
  //   MedicineListEvent event,
  // ) async* {
  //   yield MedicineLoading();
  //   if (event is GetMedicine) {
  //     FamilyMainResult member =
  //         await SharedPreferenceHelper.getSelectedFamilyPref();
  //     if (member != null) {
  //       Either<AppError, List<MedicineData>> inv =
  //           await otherDataSource.getMedicine(member.family_member.id);
  //       yield inv.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return LoadError(
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           return Loaded(
  //             invoices: r,
  //           );
  //         },
  //       );
  //     } else {
  //       print('no dat medicine member');
  //       yield LoadError(
  //         errorType: AppErrorType.api,
  //       );
  //     }
  //   }
  // }
}
