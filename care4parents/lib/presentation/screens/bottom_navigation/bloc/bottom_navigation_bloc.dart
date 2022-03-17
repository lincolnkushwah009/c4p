import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/presentation/screens/record_vital/view/record_vital_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int currentIndex = 0;
  BottomNavigationBloc() : super(PageLoading()) {
    on<PageTapped>(
      (event, emit) async {
        emit(PageLoading());
        this.currentIndex = event.index;
        emit(CurrentIndexChanged(currentIndex: this.currentIndex));
        emit(PageLoading());
        switch (event.index) {
          case -1:
            print('tab-1');
            emit(DashboardPageLoaded());
            break;
          case 0:
            print('tab1');
            emit(AppointmentPageLoaded());
            break;
          case 1:
            print('tab2');
            emit(ReportsPageLoaded());
            break;
          case 2:
            print('tab3');
            emit(RecordVitalPageLoaded());
            break;
          case 3:
            print('tab3');
            emit(UploadPageLoaded());
            break;
        }
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<BottomNavigationState> mapEventToState(
  //   BottomNavigationEvent event,
  // ) async* {
  //   yield PageLoading();
  //   if (event is PageTapped) {
  //     this.currentIndex = event.index;
  //     yield CurrentIndexChanged(currentIndex: this.currentIndex);
  //     yield PageLoading();
  //     switch (event.index) {
  //       case -1:
  //         print('tab-1');
  //         yield DashboardPageLoaded();
  //         break;
  //       case 0:
  //         print('tab1');
  //         yield AppointmentPageLoaded();
  //         break;
  //       case 1:
  //         print('tab2');
  //         yield ReportsPageLoaded();
  //         break;
  //       case 2:
  //         print('tab3');
  //         yield RecordVitalPageLoaded();
  //         break;
  //       case 3:
  //         print('tab3');
  //         yield UploadPageLoaded();
  //         break;
  //     }
  // }
  // }
}
