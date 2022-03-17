part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailState extends Equatable {
  const AppointmentDetailState();

  @override
  List<Object> get props => [];
}

class AppointmentDetailInitial extends AppointmentDetailState {}

class Loading extends AppointmentDetailState {}

class Loaded extends AppointmentDetailState {
  final List<Prescription> prescriptions;
  final List<Immunization> immunization;

  const Loaded({ this.prescriptions, this.immunization});

  @override
  List<Object> get props => [prescriptions, immunization];
}

class LoadError extends AppointmentDetailState {
  final AppErrorType errorType;

  const LoadError({
    @required this.errorType,
  });
}
