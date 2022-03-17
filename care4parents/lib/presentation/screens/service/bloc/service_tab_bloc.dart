import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'service_tab_event.dart';
part 'service_tab_state.dart';

class ServiceTabBloc extends Bloc<ServiceTabEvent, ServiceTabState> {
  final GetServices getServices;
  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  ServiceTabBloc({this.getServices}) : super(ServiceTabInitial()) {
    on<ServiceTabChangedEvent>(
      (event, emit) async {
        emit(ServiceTabLoading());
        Either<AppError, List<Service>> servicesEither =
            await getServices(event.currentTabIndex);

        emit(servicesEither.fold(
          (l) => ServiceTabLoadError(
            currentTabIndex: event.currentTabIndex,
            errorType: l.appErrorType,
          ),
          (appointments) {
            return ServiceTabChanged(
              currentTabIndex: event.currentTabIndex,
              appointments: appointments,
            );
          },
        ));
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<ServiceTabState> mapEventToState(
  //   ServiceTabEvent event,
  // ) async* {
  //   yield ServiceTabLoading();
  //   if (event is ServiceTabChangedEvent) {
  //     Either<AppError, List<Service>> servicesEither =
  //         await getServices(event.currentTabIndex);

  //     yield servicesEither.fold(
  //       (l) => ServiceTabLoadError(
  //         currentTabIndex: event.currentTabIndex,
  //         errorType: l.appErrorType,
  //       ),
  //       (appointments) {
  //         return ServiceTabChanged(
  //           currentTabIndex: event.currentTabIndex,
  //           appointments: appointments,
  //         );
  //       },
  //     );
  //   }
  // }

  dispose() {
    _loadingController.close();
  }
}
