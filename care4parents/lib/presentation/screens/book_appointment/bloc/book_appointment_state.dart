part of 'book_appointment_bloc.dart';

class BookAppointmentState extends Equatable {
  BookAppointmentState(
      {this.status = FormzStatus.pure,
      this.status2 = FormzStatus.pure,
      this.statusCoupon = FormzStatus.pure,
      this.statusPurchageOne = FormzStatus.pure,
      this.statusPurchageTwo = FormzStatus.pure,
      this.statusCareStatus = FormzStatus.pure,
      this.specialist = const NotEmptyField.pure(),
      this.date = const NotEmptyField.pure(),
      this.phone = const PhoneNumber.pure(),
      this.remark = const NotEmptyField.pure(),
      this.name = const NotEmptyField.pure(),
      this.amount = const NotEmptyField.pure(),
      this.address = const NotEmptyField.pure(),
      this.dateMember = const NotEmptyField.pure(),
      this.fees,
      this.memberId,
      this.service,
      this.relation,
      this.member,
      this.pckgitem,
      this.rozorpayDes,
      this.newMemberphone = const PhoneNumber.pure(),
      this.email = const Email.pure(),
      this.state = const NotEmptyField.pure(),
      this.pincode = const NotEmptyField.pure(),
      this.contactPerson = const NotEmptyField.pure(),
      this.newMemberEmergenncyphone = const PhoneNumber.pure(),
      this.discount,
      this.couponError,
      this.couponCode});
  final FormzStatus statusPurchageOne;
  final FormzStatus statusPurchageTwo;
  final FormzStatus status;
  final FormzStatus statusCoupon;
  final FormzStatus statusCareStatus;
  final FormzStatus status2;
  final NotEmptyField specialist;
  final NotEmptyField date;
  final PhoneNumber phone;
  final PhoneNumber newMemberphone, newMemberEmergenncyphone;
  final NotEmptyField remark;
  final NotEmptyField name;
  final NotEmptyField amount;
  final NotEmptyField address;
  final FamilyMainResult member;
  final NotEmptyField dateMember;
  final ServiceType service, relation;
  final Email email;
  final String couponError;
  final String discount;

  final NotEmptyField state;
  final NotEmptyField pincode;
  final NotEmptyField contactPerson;
  final String couponCode;
  Package pckgitem;
  final int fees;
  final int memberId;

  String rozorpayDes;
  BookAppointmentState copyWith(
      {FormzStatus status,
      FormzStatus status2,
      FormzStatus statusCoupon,
      FormzStatus statusPurchageOne,
      FormzStatus statusPurchageTwo,
      NotEmptyField specialist,
      NotEmptyField date,
      PhoneNumber phone,
      NotEmptyField remark,
      FamilyMainResult member,
      int fees,
      ServiceType service,
      ServiceType relation,
      NotEmptyField dateMember,
      NotEmptyField address,
      PhoneNumber newMemberphone,
      PhoneNumber newMemberEmergenncyphone,
      NotEmptyField name,
      int memberId,
      Package pckgitem,
      Email email,
      NotEmptyField state,
      NotEmptyField pincode,
      NotEmptyField contactPerson,
      NotEmptyField amount,
      String couponCode,
      FormzStatus statusCareStatus,
      String couponError,
      String rozorpayDes,
      String discount}) {
    return BookAppointmentState(
      status: status ?? this.status,
      status2: status2 ?? this.status2,
      statusCoupon: statusCoupon ?? this.statusCoupon,
      statusPurchageOne: statusPurchageOne ?? this.statusPurchageOne,
      statusPurchageTwo: statusPurchageTwo ?? this.statusPurchageTwo,
      specialist: specialist ?? this.specialist,
      date: date ?? this.date,
      phone: phone ?? this.phone,
      remark: remark ?? this.remark,
      member: member ?? this.member,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      service: service ?? this.service,
      dateMember: dateMember ?? this.dateMember,
      address: address ?? this.address,
      newMemberphone: newMemberphone ?? this.newMemberphone,
      name: name ?? this.name,
      memberId: memberId ?? this.memberId,
      pckgitem: pckgitem ?? this.pckgitem,
      relation: relation ?? this.relation,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      rozorpayDes: rozorpayDes ?? this.rozorpayDes,
      newMemberEmergenncyphone:
          newMemberEmergenncyphone ?? this.newMemberEmergenncyphone,
      statusCareStatus: statusCareStatus ?? this.statusCareStatus,
      couponCode: couponCode ?? this.couponCode,
      couponError: couponError ?? this.couponError,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object> get props => [
        status,
        status2,
        statusCoupon,
        specialist,
        date,
        member,
        fees,
        service,
        dateMember,
        address,
        newMemberphone,
        name,
        remark,
        phone,
        memberId,
        pckgitem,
        email,
        state,
        pincode,
        contactPerson,
        newMemberEmergenncyphone,
        relation,
        statusPurchageOne,
        statusPurchageTwo,
        amount,
        statusCareStatus,
        rozorpayDes,
        couponCode,
        discount
      ];
}
