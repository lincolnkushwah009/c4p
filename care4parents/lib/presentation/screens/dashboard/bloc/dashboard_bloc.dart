import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetUserFamilyList getFamilyList;

  DashboardBloc({@required this.getFamilyList}) : super(DashboardInitial()) {
    on<GetFamilyList>(
      (event, emit) async {
        emit(PageLoading());
        await _mapGetFamilyList(event, state, emit);
      },
      transformer: sequential(),
    );
    on<UpdateSelectedFamilyMemberId>(
      (event, emit) async {
        emit(PageLoading());

        await _mapUdateFamilyMemberId(event);
      },
      transformer: sequential(),
    );
    on<LoadFamilyList>(
      (event, emit) async {
        emit(PageLoading());

        await _mapFamilyMembers(event, emit);
      },
      transformer: sequential(),
    );
    on<GetMemberList>(
      (event, emit) async {
        emit(PageLoading());

        await _mapMemberList(event);
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<DashboardState> mapEventToState(
  //   DashboardEvent event,
  // ) async* {
  //   yield PageLoading();
  //   switch (event.runtimeType) {
  //     case GetFamilyList:
  //       // yield* _mapGetFamilyList(event, state);
  //       break;
  //     case UpdateSelectedFamilyMemberId:
  //       // yield* _mapUdateFamilyMemberId(event);
  //       break;
  //     case LoadFamilyList:
  //       // yield* _mapFamilyMembers(event);
  //       break;
  //     case GetMemberList:
  //       // yield* _mapMemberList(event);
  //       break;
  //     default:
  //   }
  // }

  _mapGetFamilyList(
    GetFamilyList event,
    DashboardState state,
    Emitter<DashboardState> emit,
  ) async {
    User user = await SharedPreferenceHelper.getUserPref();
    FamilyMainResult familyM =
        await SharedPreferenceHelper.getSelectedFamilyPref();

    Either<AppError, List<FamilyMainResult>> familyListEither =
        await getFamilyList(FamilyQueryParams(
            limit: 100, page: 1, dquery: DqueryParam(user_id: user.id)));
    emit(familyListEither.fold(
      (l) {
        print('No family member found.');

        return FamilyLoadError(
          errorType: l.appErrorType,
        );
      },
      // ignore: missing_return
      (familyList) {
        if (!familyList.isEmpty) {
          getFamily();
          SharedPreferenceHelper.setFamilyMermbersPref(familyList);
          if (familyM == null) setFamily(familyList[0]);

          // SharedPreferenceHelper.setSelectedFamilyPref(familyList[0]);
        }
        this.add(LoadFamilyList(
            userList: familyList,
            selectedId: familyM == null
                ? familyList[0].family_member.id
                : familyM.family_member.id));

        // return LoadedFamilyList(
        //     userList: familyList,
        //     selectedId: familyM == null
        //         ? familyList[0].family_member.id
        //         : familyM.family_member.id);
      },
    ));
  }

  _mapFamilyMembers(LoadFamilyList event, Emitter<DashboardState> emit) async {
    List<FamilyMainResult> familyList =
        await SharedPreferenceHelper.getFamilyMermbersPref();

    // _listTodo[event.index] = item.copyWith(showGraph: !item.showGraph);
    emit(LoadedFamilyList(userList: familyList, selectedId: event.selectedId));
  }

  _mapUdateFamilyMemberId(UpdateSelectedFamilyMemberId event) async {
    List<FamilyMainResult> familyList =
        await SharedPreferenceHelper.getFamilyMermbersPref();

    // await SharedPreferenceHelper.setSelectedFamilyPref(event.member);
    await setFamily(event.member);

    this.add(LoadFamilyList(
        userList: familyList, selectedId: event.selectedFamilyMemberId));
  }

  _mapMemberList(GetMemberList event) async {
    List<FamilyMainResult> familyList = [];
    FamilyMember familyMember = await SharedPreferenceHelper.getFamilyPref();
    if (familyMember != null) {
      final data = familyMember.toJson();
      //  json.decode(familyMember.toString());
      FamilyMainResult fMain = FamilyMainResult.fromJson({
        'family_member': familyMember.toJson(),
        'family_member_id': familyMember.id
      });
      familyList.add(fMain);
      await setFamily(fMain);
      // await SharedPreferenceHelper.setSelectedFamilyPref(fMain);
      // await SharedPreferenceHelper.setString(
      //     fMain.family_member.phone, 'membermobile');
      // await SharedPreferenceHelper.setString(
      //     fMain.family_member.name, 'membername');
      // await SharedPreferenceHelper.setString(
      //     fMain.family_member.gender, 'membergender');
      SharedPreferenceHelper.setFamilyMermbersPref(familyList);
    }
    print('familyList' + familyList.toString());
    this.add(LoadFamilyList(
        userList: familyList,
        selectedId: familyMember != null ? familyMember.id : null));
  }
}

setFamily(FamilyMainResult fMain) async {
  await SharedPreferenceHelper.setSelectedFamilyPref(fMain);
  await SharedPreferenceHelper.setMMPref(fMain.family_member.phone);
  await SharedPreferenceHelper.setMNPref(fMain.family_member.name);
  await SharedPreferenceHelper.setMGPref(fMain.family_member.gender);
  await getFamily();
}

getFamily() async {
  final String mm = await SharedPreferenceHelper.getMMPref();
  final String mn = await SharedPreferenceHelper.getMGPref();
  final String mg = await SharedPreferenceHelper.getMNPref();
  print('getFamily %%%%%%%%%%%%%%%%%%%%%%%%%% main %%%%%%%%%%%%%%%%%% ' +
      mm.toString() +
      mn.toString() +
      mg.toString());
}
