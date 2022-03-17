part of 'appointment_tab_bloc.dart';

abstract class AppointmentTabEvent extends Equatable {
  const AppointmentTabEvent();

  @override
  List<Object> get props => [];
}

class AppointmentTabChangedEvent extends AppointmentTabEvent {
  final int currentTabIndex;

  const AppointmentTabChangedEvent({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class CancelAppointment extends AppointmentTabEvent {
  final int appointment_id;

  const CancelAppointment({this.appointment_id});

  @override
  List<Object> get props => [appointment_id];
}
