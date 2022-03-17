part of 'book_appointment_bloc.dart';

abstract class BookAppointmentEvent extends Equatable {
  const BookAppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentSpecialistChanged extends BookAppointmentEvent {
  const AppointmentSpecialistChanged(this.specialist);
  final String specialist;

  @override
  List<Object> get props => [specialist];
}

class AppointmentMemberChanged extends BookAppointmentEvent {
  const AppointmentMemberChanged(this.member);
  final FamilyMainResult member;

  @override
  List<Object> get props => [member];
}

class AppointmentDateChanged extends BookAppointmentEvent {
  const AppointmentDateChanged(this.date);
  final String date;

  @override
  List<Object> get props => [date];
}

class AppointmentPhoneChanged extends BookAppointmentEvent {
  const AppointmentPhoneChanged(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

class AppointmentRemarkChanged extends BookAppointmentEvent {
  const AppointmentRemarkChanged(this.remark);
  final String remark;

  @override
  List<Object> get props => [remark];
}

class BookAppointmentSubmitted extends BookAppointmentEvent {}

class CareCashSubmitted extends BookAppointmentEvent {}

class NewMemberSubmitted extends BookAppointmentEvent {}

class BookServiceSubmitted extends BookAppointmentEvent {}

class PurchagePlanMemberSubmitted extends BookAppointmentEvent {}

class NewMemberNameChanged extends BookAppointmentEvent {
  const NewMemberNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class CareCashAmountChanged extends BookAppointmentEvent {
  const CareCashAmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

class PurchageNewMemberNameChanged extends BookAppointmentEvent {
  const PurchageNewMemberNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class NewMemberIdChanged extends BookAppointmentEvent {
  const NewMemberIdChanged(this.memberId);

  final String memberId;

  @override
  List<Object> get props => [memberId];
}

class NewMemberAddressChanged extends BookAppointmentEvent {
  const NewMemberAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class PurchageNewMemberAddressChanged extends BookAppointmentEvent {
  const PurchageNewMemberAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class NewMemberStateChanged extends BookAppointmentEvent {
  const NewMemberStateChanged(this.state);

  final String state;

  @override
  List<Object> get props => [state];
}

class NewMemberPincodeChanged extends BookAppointmentEvent {
  const NewMemberPincodeChanged(this.pincode);

  final String pincode;

  @override
  List<Object> get props => [pincode];
}

class NewMemberEmergenncyphoneChanged extends BookAppointmentEvent {
  const NewMemberEmergenncyphoneChanged(this.newMemberEmergenncyphone);

  final String newMemberEmergenncyphone;

  @override
  List<Object> get props => [newMemberEmergenncyphone];
}

class NewMemberContactPersonChanged extends BookAppointmentEvent {
  const NewMemberContactPersonChanged(this.contactPerson);

  final String contactPerson;

  @override
  List<Object> get props => [contactPerson];
}

class NewMemberEmailChanged extends BookAppointmentEvent {
  const NewMemberEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class NewMemberPhoneChanged extends BookAppointmentEvent {
  const NewMemberPhoneChanged(this.newMemberphone);

  final String newMemberphone;

  @override
  List<Object> get props => [newMemberphone];
}

class PurchageNewMemberPhoneChanged extends BookAppointmentEvent {
  const PurchageNewMemberPhoneChanged(this.newMemberphone);

  final String newMemberphone;

  @override
  List<Object> get props => [newMemberphone];
}

class ServiceDateChanged extends BookAppointmentEvent {
  const ServiceDateChanged(this.dateMember);
  final String dateMember;

  @override
  List<Object> get props => [dateMember];
}

class PurchageDateChanged extends BookAppointmentEvent {
  const PurchageDateChanged(this.dateMember);
  final String dateMember;

  @override
  List<Object> get props => [dateMember];
}

class ServiceChanged extends BookAppointmentEvent {
  const ServiceChanged(this.service);
  final ServiceType service;

  @override
  List<Object> get props => [service];
}

class RelationChanged extends BookAppointmentEvent {
  const RelationChanged(this.relation);
  final ServiceType relation;

  @override
  List<Object> get props => [relation];
}

class GetPaymentFee extends BookAppointmentEvent {
  const GetPaymentFee(this.appointment_id);
  final int appointment_id;

  @override
  List<Object> get props => [appointment_id];
}

class PurchageProceedToPayment extends BookAppointmentEvent {
  const PurchageProceedToPayment(this.pckgitem);
  final Package pckgitem;

  @override
  List<Object> get props => [pckgitem];
}

class ProceedToPayment extends BookAppointmentEvent {
  const ProceedToPayment(this.amount);
  final int amount;

  @override
  List<Object> get props => [amount];
}

class CheckCouponValid extends BookAppointmentEvent {
  const CheckCouponValid(this.coupon_code, this.pkgItem, this.amount);
  final String coupon_code;
  final String pkgItem;
  final int amount;

  @override
  List<Object> get props => [coupon_code, pkgItem, amount];
}

class CouponChange extends BookAppointmentEvent {
  const CouponChange(this.coupon_code);
  final String coupon_code;

  @override
  List<Object> get props => [coupon_code];
}
