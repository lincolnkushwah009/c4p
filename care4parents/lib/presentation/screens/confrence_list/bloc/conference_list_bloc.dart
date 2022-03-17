import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'conference_list_event.dart';
part 'conference_list_state.dart';

class ConferenceListBloc
    extends Bloc<ConferenceListEvent, ConferenceListState> {
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  ConferenceListBloc({this.otherDataSource})
      : super(ConferenceListInitial());

  @override
  Stream<ConferenceListState> mapEventToState(
      ConferenceListEvent event,
  ) async* {
    yield Loading();
    if (event is GetConference) {
      FamilyMainResult member =
      await SharedPreferenceHelper.getSelectedFamilyPref();
      Either<AppError, List<MedicineData>> inv = await otherDataSource.getConference(member.family_member.id);
      yield inv.fold(
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
      );
    }
  }
}
