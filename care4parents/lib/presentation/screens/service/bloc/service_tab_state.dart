part of 'service_tab_bloc.dart';

abstract class ServiceTabState extends Equatable {
  final int currentTabIndex;

  const ServiceTabState({this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class ServiceTabInitial extends ServiceTabState {}

class ServiceTabLoading extends ServiceTabState {}

class ServiceTabChanged extends ServiceTabState {
  final List<Service> appointments;

  const ServiceTabChanged({int currentTabIndex, this.appointments})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, appointments];
}

class ServiceTabLoadError extends ServiceTabState {
  final AppErrorType errorType;

  const ServiceTabLoadError({
    int currentTabIndex,
    @required this.errorType,
  }) : super(currentTabIndex: currentTabIndex);
}
