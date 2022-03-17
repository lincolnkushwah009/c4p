part of 'activity_tab_bloc.dart';

abstract class ActivityTabState extends Equatable {
  final int currentTabIndex;

  const ActivityTabState({this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class ActivityTabInitial extends ActivityTabState {}

class ActivityTabLoading extends ActivityTabState {}

class ActivityTabChanged extends ActivityTabState {
  final List<ActivityResult> activities;
  final List<PreviousReport> previousReports;

  const ActivityTabChanged(
      {int currentTabIndex, this.activities, this.previousReports})
      : super(
          currentTabIndex: currentTabIndex,
        );

  @override
  List<Object> get props => [currentTabIndex, activities];
}

class ActivityTabLoadError extends ActivityTabState {
  final AppErrorType errorType;

  const ActivityTabLoadError({
    int currentTabIndex,
    @required this.errorType,
  }) : super(currentTabIndex: currentTabIndex);
}
