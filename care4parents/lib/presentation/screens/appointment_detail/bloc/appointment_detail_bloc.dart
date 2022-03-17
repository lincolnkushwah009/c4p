import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/prescription.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'appointment_detail_event.dart';
part 'appointment_detail_state.dart';

class AppointmentDetailBloc
    extends Bloc<AppointmentDetailEvent, AppointmentDetailState> {
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  AppointmentDetailBloc({this.otherDataSource})
      : super(AppointmentDetailInitial());

  @override
  Stream<AppointmentDetailState> mapEventToState(
    AppointmentDetailEvent event,
  ) async* {
    yield Loading();
    if (event is GetPrescription) {
      Either<AppError, PrescriptionMain> activitysEither =
          await otherDataSource.getPrescriptions(event.id);
      yield activitysEither.fold(
        (l) {
          print('left error >>>>>');
          return LoadError(
            errorType: l.appErrorType,
          );
        },
        (r) {
          return Loaded(
            prescriptions: r.drprescriptionmedicine,
            immunization: r.immunization
          );
        },
      );
    }
  }
}
