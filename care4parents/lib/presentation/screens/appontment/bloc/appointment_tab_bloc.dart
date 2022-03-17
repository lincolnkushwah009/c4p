import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:care4parents/data/models/appointment_model.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'appointment_tab_event.dart';
part 'appointment_tab_state.dart';

class AppointmentTabBloc
    extends Bloc<AppointmentTabEvent, AppointmentTabState> {
  final GetUpcomingAppointments getUpcomingAppointments;
  final GetRequestedAppointments getRequestedAppointments;
  final OtherRemoteDataSource otherRemoteDataSource;
  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  AppointmentTabBloc(
      {this.getUpcomingAppointments,
      this.getRequestedAppointments,
      this.otherRemoteDataSource})
      : super(AppointmentTabInitial()) {
    on<AppointmentTabChangedEvent>(
      (event, emit) async {
        emit(AppointmentTabLoading());
        Either<AppError, List<AppointmentModel>> appointmentsEither =
            await getUpcomingAppointments(event.currentTabIndex);

        emit(appointmentsEither.fold(
          (l) => AppointmentTabLoadError(
            currentTabIndex: event.currentTabIndex,
            errorType: l.appErrorType,
          ),
          (appointments) {
            return AppointmentTabChanged(
              currentTabIndex: event.currentTabIndex,
              appointments: appointments,
            );
          },
        ));
      },
      transformer: sequential(),
    );
    on<CancelAppointment>(
      (event, emit) async {
        emit(AppointmentTabLoading());
        Either<AppError, ObjectCommonResult> appointmentsEither =
            await otherRemoteDataSource.cancelAppointment(event.appointment_id);

        emit(appointmentsEither.fold(
          (l) => AppointmentTabLoadError(
            errorType: l.appErrorType,
          ),
          (appointments) {
            this.add(AppointmentTabChangedEvent(currentTabIndex: 0));
            // return AppointmentTabChanged(
            // currentTabIndex: event.currentTabIndex,
            // appointments: appointments,
            // );
          },
        ));
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<AppointmentTabState> mapEventToState(
  //   AppointmentTabEvent event,
  // ) async* {
  //   yield AppointmentTabLoading();
  //   if (event is AppointmentTabChangedEvent) {
  //     Either<AppError, List<AppointmentModel>> appointmentsEither =
  //         await getUpcomingAppointments(event.currentTabIndex);

  //     yield appointmentsEither.fold(
  //       (l) => AppointmentTabLoadError(
  //         currentTabIndex: event.currentTabIndex,
  //         errorType: l.appErrorType,
  //       ),
  //       (appointments) {
  //         return AppointmentTabChanged(
  //           currentTabIndex: event.currentTabIndex,
  //           appointments: appointments,
  //         );
  //       },
  //     );
  //   } else if (event is CancelAppointment) {
  //     Either<AppError, ObjectCommonResult> appointmentsEither =
  //         await otherRemoteDataSource.cancelAppointment(event.appointment_id);

  //     yield appointmentsEither.fold(
  //       (l) => AppointmentTabLoadError(
  //         errorType: l.appErrorType,
  //       ),
  //       (appointments) {
  //         this.add(AppointmentTabChangedEvent(currentTabIndex: 0));
  //         // return AppointmentTabChanged(
  //         // currentTabIndex: event.currentTabIndex,
  //         // appointments: appointments,
  //         // );
  //       },
  //     );
  //   }
  // }

  dispose() {
    _loadingController.close();
  }
}
