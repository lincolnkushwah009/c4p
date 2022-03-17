part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailEvent extends Equatable {
  const AppointmentDetailEvent();

  @override
  List<Object> get props => [];
}

class GetPrescription extends AppointmentDetailEvent {
  final int id;

  const GetPrescription({this.id});

  @override
  List<Object> get props => [id];
}
