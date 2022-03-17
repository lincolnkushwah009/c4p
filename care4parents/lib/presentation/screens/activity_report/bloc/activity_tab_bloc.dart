import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/activity_result.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/previous_report_result.dart';
import 'package:care4parents/domain/entities/activity_entity.dart';
import 'package:care4parents/domain/entities/app_error.dart';
// import 'package:care4parents/domain/entities/Activity_entity.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/helper/shared_preferences.dart';
// import 'package:care4parents/domain/usecases/get_Activitys.dart';
// import 'package:care4parents/presentation/screens/appontment/Activity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'activity_tab_event.dart';
part 'activity_tab_state.dart';

class ActivityTabBloc extends Bloc<ActivityTabEvent, ActivityTabState> {
  // final GetActivitys getUpcomingActivitys;
  // final GetRequestedActivitys getRequestedActivitys;
  OtherRemoteDataSource otherDataSource;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  ActivityTabBloc({this.otherDataSource}) : super(ActivityTabInitial()) {
    on<ActivityTabChangedEvent>(
      (event, emit) async {
        emit(ActivityTabLoading());
        FamilyMainResult member =
            await SharedPreferenceHelper.getSelectedFamilyPref();
        if (member != null) {
          print('member.family_member.id ====================' +
              member.family_member.id.toString());
          switch (event.currentTabIndex) {
            case 0:
              Either<AppError, List<ActivityResult>> activitysEither =
                  await otherDataSource.getActivities(member.family_member.id);
              emit(activitysEither.fold(
                (l) {
                  print('left error >>>>>');
                  return ActivityTabLoadError(
                    currentTabIndex: event.currentTabIndex,
                    errorType: l.appErrorType,
                  );
                },
                (r) {
                  return ActivityTabChanged(
                    currentTabIndex: event.currentTabIndex,
                    activities: r,
                  );
                },
              ));
              break;
            case 1:
              Either<AppError, List<ActivityResult>> reportEither =
                  await otherDataSource.getReports(member.family_member.id);
              emit(reportEither.fold(
                (l) {
                  print('left error >>>>>');
                  return ActivityTabLoadError(
                    currentTabIndex: event.currentTabIndex,
                    errorType: l.appErrorType,
                  );
                },
                (r) {
                  return ActivityTabChanged(
                    currentTabIndex: event.currentTabIndex,
                    activities: r,
                  );
                },
              ));
              break;
            case 2:
              Either<AppError, List<PreviousReport>> reportsEither =
                  await otherDataSource
                      .getPreviousReports(member.family_member.id);
              emit(reportsEither.fold(
                (l) {
                  print('left error >>>>>');
                  return ActivityTabLoadError(
                    currentTabIndex: event.currentTabIndex,
                    errorType: l.appErrorType,
                  );
                },
                (r) {
                  print('r' + r.toString());
                  return ActivityTabChanged(
                    currentTabIndex: event.currentTabIndex,
                    previousReports: r,
                  );
                },
              ));
              break;

            // case 2:
            //   activitysEither = await getRequestedActivitys(NoParams());
            //   break;
          }
          ;
        } else {
          emit(ActivityTabLoadError(
            currentTabIndex: event.currentTabIndex,
            errorType: AppErrorType.api,
          ));
        }
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<ActivityTabState> mapEventToState(
  //   ActivityTabEvent event,
  // ) async* {
  //   yield ActivityTabLoading();
  //   if (event is ActivityTabChangedEvent) {
  // FamilyMainResult member =
  //     await SharedPreferenceHelper.getSelectedFamilyPref();
  // if (member != null) {
  //   print('member.family_member.id ====================' +
  //       member.family_member.id.toString());
  //   switch (event.currentTabIndex) {
  //     case 0:
  //       Either<AppError, List<ActivityResult>> activitysEither =
  //           await otherDataSource.getActivities(member.family_member.id);
  //       yield activitysEither.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return ActivityTabLoadError(
  //             currentTabIndex: event.currentTabIndex,
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           return ActivityTabChanged(
  //             currentTabIndex: event.currentTabIndex,
  //             activities: r,
  //           );
  //         },
  //       );
  //       break;
  //     case 1:
  //       Either<AppError, List<ActivityResult>> reportEither =
  //           await otherDataSource.getReports(member.family_member.id);
  //       yield reportEither.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return ActivityTabLoadError(
  //             currentTabIndex: event.currentTabIndex,
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           return ActivityTabChanged(
  //             currentTabIndex: event.currentTabIndex,
  //             activities: r,
  //           );
  //         },
  //       );
  //       break;
  //     case 2:
  //       Either<AppError, List<PreviousReport>> reportsEither =
  //           await otherDataSource
  //               .getPreviousReports(member.family_member.id);
  //       yield reportsEither.fold(
  //         (l) {
  //           print('left error >>>>>');
  //           return ActivityTabLoadError(
  //             currentTabIndex: event.currentTabIndex,
  //             errorType: l.appErrorType,
  //           );
  //         },
  //         (r) {
  //           print('r' + r.toString());
  //           return ActivityTabChanged(
  //             currentTabIndex: event.currentTabIndex,
  //             previousReports: r,
  //           );
  //         },
  //       );
  //       break;

  //     // case 2:
  //     //   activitysEither = await getRequestedActivitys(NoParams());
  //     //   break;
  //   }
  //   ;
  // } else {
  //   yield ActivityTabLoadError(
  //     currentTabIndex: event.currentTabIndex,
  //     errorType: AppErrorType.api,
  //   );
  // }

  // ActivityEntity a = ActivityEntity(
  //     id: 1,
  //     name: 'Helth Calender',
  //     status: 'Executed',
  //     schedule_date: '2021-04-01',
  //     execution_date: '2021-04-01');
  // List<ActivityEntity> activities = new List<ActivityEntity>();
  // activities.add(a);
  // activities.add(a);

  // yield ActivityTabChanged(
  //   currentTabIndex: event.currentTabIndex,
  //   activities: activities,
  // );

  //   }
  // }

  dispose() {
    _loadingController.close();
  }
}
