part of 'appointment_tab_bloc.dart';

abstract class AppointmentTabState extends Equatable {
  final int currentTabIndex;

  const AppointmentTabState({this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class AppointmentTabInitial extends AppointmentTabState {}

class AppointmentTabLoading extends AppointmentTabState {}

class AppointmentTabChanged extends AppointmentTabState {
  final List<AppointmentModel> appointments;

  const AppointmentTabChanged({int currentTabIndex, this.appointments})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, appointments];
}

class AppointmentTabLoadError extends AppointmentTabState {
  final AppErrorType errorType;

  const AppointmentTabLoadError({
    int currentTabIndex,
    @required this.errorType,
  }) : super(currentTabIndex: currentTabIndex);
}
