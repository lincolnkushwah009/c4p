part of 'book_service_bloc.dart';

abstract class BookServiceEvent extends Equatable {
  const BookServiceEvent();

  @override
  List<Object> get props => [];
}

class ServiceSpecialistChanged extends BookServiceEvent {
  const ServiceSpecialistChanged(this.specialist);
  final String specialist;

  @override
  List<Object> get props => [specialist];
}

class ServiceMemberChanged extends BookServiceEvent {
  const ServiceMemberChanged(this.member);
  final FamilyMainResult member;

  @override
  List<Object> get props => [member];
}

class ServiceDateChanged extends BookServiceEvent {
  const ServiceDateChanged(this.date);
  final String date;

  @override
  List<Object> get props => [date];
}

class ServicePhoneChanged extends BookServiceEvent {
  const ServicePhoneChanged(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

class ServiceRemarkChanged extends BookServiceEvent {
  const ServiceRemarkChanged(this.remark);
  final String remark;

  @override
  List<Object> get props => [remark];
}

class BookServiceSubmitted extends BookServiceEvent {}
