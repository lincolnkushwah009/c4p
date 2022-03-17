part of 'service_tab_bloc.dart';

abstract class ServiceTabEvent extends Equatable {
  const ServiceTabEvent();

  @override
  List<Object> get props => [];
}

class ServiceTabChangedEvent extends ServiceTabEvent {
  final int currentTabIndex;

  const ServiceTabChangedEvent({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}
