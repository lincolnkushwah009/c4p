part of 'activity_tab_bloc.dart';

abstract class ActivityTabEvent extends Equatable {
  const ActivityTabEvent();

  @override
  List<Object> get props => [];
}

class ActivityTabChangedEvent extends ActivityTabEvent {
  final int currentTabIndex;

  const ActivityTabChangedEvent({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}
