import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MemberParams extends Equatable {
  final String name;
  final String relation;
  final String dob;
  final String gender;
  final int user_id;
  final String email;
  final String address;
  final String phone;
  final String emergency_country_code;
  final String emergency_contact_no;
  final String emergency_contact_person;

  MemberParams({
    @required this.name,
    @required this.relation,
    @required this.dob,
    @required this.gender,
    this.user_id,
    @required this.email,
    @required this.address,
    @required this.phone,
    @required this.emergency_country_code,
    @required this.emergency_contact_no,
    @required this.emergency_contact_person,
  });

  @override
  List<Object> get props => [
        name,
        relation,
        dob,
        gender,
        user_id,
        email,
        address,
        phone,
        emergency_contact_no,
        emergency_contact_person,
        emergency_country_code
      ];
  Map<String, dynamic> toJson() => {
        'name': name,
        'relation': relation,
        'dob': dob,
        'gender': gender,
        'user_id': user_id,
        'email': email,
        'address': address,
        'phone': phone,
        'emergency_contact_no': emergency_contact_no,
        'emergency_contact_person': emergency_contact_person,
        'emergency_country_code': emergency_country_code,
      };
}

class MemberMappingParams extends Equatable {
  final int user_id;
  final int family_member_id;

  MemberMappingParams({
    this.user_id,
    this.family_member_id,
  });

  @override
  List<Object> get props => [
        user_id,
        family_member_id,
      ];
  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'family_member_id': family_member_id,
      };
}

class AddCareCashMappingParams extends Equatable {
  String patientId;
  String amount;
  String reason;
  RozorPayMappingParams razorpay_response;

  AddCareCashMappingParams({
    this.patientId,
    this.amount,
    this.reason,
    this.razorpay_response,
  });

  @override
  List<Object> get props => [patientId, amount, reason, razorpay_response];
  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'amount': amount,
        'reason': reason,
        'razorpay_response': razorpay_response
      };

  AddCareCashMappingParams.fromJsonParams(Map<String, dynamic> json) {
    patientId = json['patientId'] as String;
    amount = json['amount'] as String;

    reason = json['reason'] as String;
    razorpay_response = json['razorpay_response'] as Object;
  }
}

class RozorPayMappingParams extends Equatable {
  String razorpay_payment_id;
  String orderId;
  String signature;

  RozorPayMappingParams({
    this.razorpay_payment_id,
    this.orderId,
    this.signature,
  });

  @override
  List<Object> get props => [razorpay_payment_id, orderId, signature];
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'razorpay_payment_id': razorpay_payment_id,
        'signature': signature,
      };

  RozorPayMappingParams.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];

    razorpay_payment_id = json['razorpay_payment_id'];
    signature = json['signature'];
  }
}

class OrderParams extends Equatable {
  final String package;
  final int family_member;
  final int quantity;
  final int user;
  final String name;
  final String order_datetime;
  final String phone;
  final String state;
  final String status;
  final String address;
  final String pincode;
  final int amount;
  final String promocode_name;
  final String discount_amount;
  final int promocode_id;

  OrderParams({
    this.pincode,
    this.package,
    this.quantity,
    this.name,
    this.user,
    this.order_datetime,
    this.phone,
    this.state,
    this.status,
    this.address,
    this.family_member,
    this.amount,
    this.promocode_name,
    this.discount_amount,
    this.promocode_id,
  });

  @override
  List<Object> get props => [
        pincode,
        package,
        quantity,
        name,
        user,
        order_datetime,
        phone,
        state,
        status,
        address,
        family_member,
        amount,
        promocode_id,
        promocode_name,
        discount_amount
      ];
  Map<String, dynamic> toJson() => {
        'pincode': pincode,
        'package': package,
        'quantity': quantity,
        'name': name,
        'user': user,
        'order_datetime': order_datetime,
        'phone': phone,
        'state': state,
        'status': status,
        'address': address,
        'family_member': family_member,
        'amount': amount,
        'promocode_id': promocode_id,
        'promocode_name': promocode_name,
        'discount_amount': discount_amount,
      };
}

class UserPackageMappingParams extends Equatable {
  final String package;
  final String family_member;
  final String order;
  final String start_date;
  final String end_time;
  final bool status;

  UserPackageMappingParams({
    @required this.family_member,
    @required this.package,
    @required this.order,
    @required this.start_date,
    @required this.end_time,
    @required this.status,
  });

  @override
  List<Object> get props => [
        family_member,
        package,
        order,
        start_date,
        end_time,
        status,
      ];
  Map<String, dynamic> toJson() => {
        'family_member': family_member,
        'package': package,
        'order': order,
        'start_date': start_date,
        'end_time': end_time,
        'status': status,
      };
}

class PuechagePackageMappingParams extends Equatable {
  final String start_date;
  final String end_time;

  final String package_id;
  final String package_code;
  final int quantity;
  final String user_id;
  final String order_datetime;
  final String status;
  final String amount;
  final String payment_id;
  final String payment_type;
  RozorPayMappingParams razorpay_response;

  PuechagePackageMappingParams(
      {@required this.package_id,
      @required this.package_code,
      @required this.quantity,
      @required this.start_date,
      @required this.end_time,
      @required this.user_id,
      @required this.order_datetime,
      @required this.status,
      @required this.amount,
      @required this.payment_id,
      @required this.payment_type,
      this.razorpay_response});

  @override
  List<Object> get props => [
        package_id,
        package_code,
        quantity,
        start_date,
        end_time,
        user_id,
        order_datetime,
        status,
        amount,
        payment_id,
        payment_type,
        razorpay_response
      ];
  Map<String, dynamic> toJson() => {
        'package_id': package_id,
        'package_code': package_code,
        'quantity': quantity,
        'start_date': start_date,
        'end_time': end_time,
        'status': status,
        'user_id': user_id,
        'order_datetime': order_datetime,
        'amount': amount,
        'payment_id': payment_id,
        'payment_type': payment_type,
        'razorpay_response': razorpay_response
      };
}

class PuechageNewMemberMappingParams extends Equatable {
  final String start_date;
  final String end_time;

  final String package_id;
  final String package_code;
  final int quantity;
  final String user_id;
  final String order_datetime;
  final String status;
  final String amount;
  final String payment_id;
  final String payment_type;

  final String name, id;
  final String relation;
  final String dob;
  final String gender;
  final String member_email;
  final String address;
  final String member_phone;
  final String pincode;
  final String state;

  final String emergency_contact_person;
  final String emergency_country_code;
  final String emergency_contact_no;
  RozorPayMappingParams razorpay_response;

  PuechageNewMemberMappingParams(
      {@required this.package_id,
      @required this.package_code,
      @required this.quantity,
      @required this.start_date,
      @required this.end_time,
      @required this.user_id,
      @required this.order_datetime,
      @required this.status,
      @required this.amount,
      @required this.payment_id,
      @required this.payment_type,
      this.name,
      this.relation,
      this.dob,
      this.gender,
      this.member_email,
      this.address,
      this.member_phone,
      this.pincode,
      this.state,
      this.emergency_contact_person,
      this.emergency_country_code,
      this.emergency_contact_no,
      this.id,
      this.razorpay_response});

  @override
  List<Object> get props => [
        package_id,
        package_code,
        quantity,
        start_date,
        end_time,
        user_id,
        order_datetime,
        status,
        amount,
        payment_id,
        payment_type,
        name,
        relation,
        dob,
        gender,
        member_email,
        address,
        member_phone,
        pincode,
        state,
        emergency_contact_person,
        emergency_country_code,
        emergency_contact_no,
        id,
        razorpay_response
      ];
  Map<String, dynamic> toJson() => {
        'package_id': package_id,
        'package_code': package_code,
        'quantity': quantity,
        'start_date': start_date,
        'end_time': end_time,
        'status': status,
        'user_id': user_id,
        'order_datetime': order_datetime,
        'amount': amount,
        'payment_id': payment_id,
        'payment_type': payment_type,
        'name': name,
        'relation': relation,
        'dob': dob,
        'gender': gender,
        'member_email': member_email,
        'address': address,
        'member_phone': member_phone,
        'pincode': pincode,
        'state': state,
        'emergency_contact_person': emergency_contact_person,
        'emergency_country_code': emergency_country_code,
        'emergency_contact_no': emergency_contact_no,
        'id': id,
        'razorpay_response': razorpay_response
      };
}

class UpdateMemberParams extends Equatable {
  final String user_package_mapping;
  final String family_member_id;

  UpdateMemberParams({
    this.user_package_mapping,
    this.family_member_id,
  });

  @override
  List<Object> get props => [user_package_mapping, family_member_id];
  Map<String, dynamic> toJson() => {
        'user_package_mapping': user_package_mapping,
        'family_member_id': family_member_id,
      };
}

class CreateServiceMappingParams extends Equatable {
  final String package;
  final int family_member_id;
  final String kid_name;
  final String kid_phone;
  final String member_name;
  final String member_phone;

  CreateServiceMappingParams({
    this.package,
    this.family_member_id,
    this.kid_name,
    this.kid_phone,
    this.member_name,
    this.member_phone,
  });

  @override
  List<Object> get props => [
        package,
        family_member_id,
        kid_name,
        kid_phone,
        member_name,
        member_phone,
      ];
  Map<String, dynamic> toJson() => {
        'package': package,
        'family_member_id': family_member_id,
        'kid_name': kid_name,
        'kid_phone': kid_phone,
        'member_name': member_name,
        'member_phone': member_phone,
      };
}

class CouponCodeParams extends Equatable {
  final String code;
  final int amount;
  final int package_id;

  CouponCodeParams({
    this.code,
    this.amount,
    this.package_id,
  });

  @override
  List<Object> get props => [code, amount, package_id];
  Map<String, dynamic> toJson() => {
        "code": code,
        "amount": amount,
        "package_id": package_id,
      };
}

class CouponCodeParams1 extends Equatable {
  final String code;
  final int amount;
  final String package_id;

  CouponCodeParams1({
    this.code,
    this.amount,
    this.package_id,
  });

  @override
  List<Object> get props => [code, amount, package_id];
  Map<String, dynamic> toJson() => {
        "code": code,
        "amount": amount,
        "package_id": package_id,
      };
}

class PromoCodeParams extends Equatable {
  final String code;
  final String amount;
  final String package_id;

  PromoCodeParams({
    this.code,
    this.amount,
    this.package_id,
  });

  @override
  List<Object> get props => [code, amount, package_id];
  Map<String, dynamic> toJson() => {
        "code": code,
        "amount": amount,
        "package_id": package_id,
      };
}

// {"limit": 25,"page": 1,"short": ["created_at", "ASC"],"dquery": {"user_id":215}}
class FamilyQueryParams extends Equatable {
  final int limit;
  final int page;
  final List<String> short;
  final DqueryParam dquery;

  FamilyQueryParams({this.limit = 25, this.page = 1, this.short, this.dquery});

  @override
  List<Object> get props => [limit, page, short, dquery];
  Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
        "short": short,
        "dquery": dquery,
      };
}

class DqueryParam extends Equatable {
  final int user_id;
  final int family_member_id;

  DqueryParam({this.user_id, this.family_member_id});

  @override
  List<Object> get props => [user_id, family_member_id];
  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "family_member_id": family_member_id,
      };
}

class FamilyMemberParams extends Equatable {
  final String phone;
  final String otp;
  final String phoneWithoutContrycode;
  final String type;
  FamilyMemberParams(
      {this.phone, this.otp, this.phoneWithoutContrycode, this.type});

  @override
  List<Object> get props => [phone, otp, phoneWithoutContrycode, type];
  Map<String, dynamic> toJson() => {
        'phone': phone,
        'otp': otp,
        'phoneWithoutContrycode': phoneWithoutContrycode,
        'type': type
      };
}
