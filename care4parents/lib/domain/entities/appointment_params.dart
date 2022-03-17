import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class AppointmentParams extends Equatable {
  final String speciality;
  final int patientId;
  final int user_id;
  final String appointDate;
  final String time;
  final String email;
  final String phone;
  final String mobile;
  final String remarks;
  final String timerange;
  final String startappointdate;
  final String endappointdate;

  final bool is_add_member;
  final String name;
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

  AppointmentParams({
    this.speciality,
    this.patientId,
    this.user_id,
    this.appointDate,
    this.time,
    this.email,
    this.phone,
    this.mobile,
    this.remarks,
    this.timerange,
    this.startappointdate,
    this.endappointdate,
    this.is_add_member,
    this.name,
    this.relation,
    this.dob,
    this.gender,
    this.member_email,
    this.address,
    this.member_phone,
    this.pincode,
    this.state,
    this. emergency_contact_person,
    this.emergency_country_code,
    this.emergency_contact_no,
  });

  @override
  List<Object> get props => [
        speciality,
        patientId,
        user_id,
        appointDate,
        time,
        email,
        phone,
        remarks,
        timerange,
        startappointdate,
        endappointdate,
        mobile,
        is_add_member,
        name,
        relation,
        dob,
        gender,
        member_email,
        address,
        member_phone,
        pincode,
        state, emergency_contact_person,
   emergency_country_code,
    emergency_contact_no,

      ];
  Map<String, dynamic> toJson() => {
        'speciality': speciality,
        'patientId': patientId,
        'user_id': user_id,
        'appointDate': appointDate,
        'time': time,
        'email': email,
        'phone': phone,
        'remarks': remarks,
        'timerange': timerange,
        'startappointdate': startappointdate,
        'endappointdate': endappointdate,
        'mobile': mobile,
        'is_add_member': is_add_member,
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
    'emergency_country_code':  emergency_country_code,
    'emergency_contact_no':  emergency_contact_no,
      };
}

class ServiceParams extends Equatable {
  final String service;
  final int patientId;
  final int user_id;
  final String bookingdate;
  final String email;
  final String phone;
  final String mobile;
  final String remarks;
  final String timerange;
  final String startbookingdate;
  final String endbookingdate;


  final bool is_add_member;
  final String name;
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

  ServiceParams({
    this.service,
    this.patientId,
    this.user_id,
    this.bookingdate,
    this.email,
    this.phone,
    this.mobile,
    this.remarks,
    this.timerange,
    this.startbookingdate,
    this.endbookingdate,


    this.is_add_member,
    this.name,
    this.relation,
    this.dob,
    this.gender,
    this.member_email,
    this.address,
    this.member_phone,
    this.pincode,
    this.state,
    this. emergency_contact_person,
    this.emergency_country_code,
    this.emergency_contact_no,
  });

  @override
  List<Object> get props => [
        service,
        patientId,
        user_id,
        bookingdate,
        email,
        phone,
        remarks,
        timerange,
        startbookingdate,
        endbookingdate,
        mobile,


    is_add_member,
    name,
    relation,
    dob,
    gender,
    member_email,
    address,
    member_phone,
    pincode,
    state, emergency_contact_person,
    emergency_country_code,
    emergency_contact_no,
      ];
  Map<String, dynamic> toJson() => {
        'service': service,
        'patientId': patientId,
        'user_id': user_id,
        'bookingdate': bookingdate,
        'email': email,
        'phone': phone,
        'remarks': remarks,
        'timerange': timerange,
        'startbookingdate': startbookingdate,
        'endbookingdate': endbookingdate,
        'mobile': mobile,


    'is_add_member': is_add_member,
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
    'emergency_country_code':  emergency_country_code,
    'emergency_contact_no':  emergency_contact_no,
      };
}
