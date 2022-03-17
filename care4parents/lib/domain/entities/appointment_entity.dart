import 'package:care4parents/data/models/family_member.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// class AppointmentEntity extends Equatable {
//   final int id;
//   final String speciality;
//   final String remarks;
//   final String appointDate;
//   final String startappointdate;
//   final String endappointdate;
//   final String specialist_type;
//   final String timerange;

//   AppointmentEntity(
//       {@required this.id,
//       @required this.speciality,
//       @required this.remarks,
//       @required this.appointDate,
//       @required this.startappointdate,
//       @required this.endappointdate,
//       @required this.specialist_type,
//       @required this.timerange});

//   @override
//   List<Object> get props => [id, speciality, timerange];
// }

import 'package:care4parents/data/models/user.dart';

class AppointmentEntity {
  int id;
  String speciality;
  String email;
  String phone;
  String timerange;
  String remarks;
  int status;
  String appointDate;
  String startappointdate;
  String endappointdate;
  Null instructions;
  Null paymentStatus;
  Null isCarecashUsed;
  String createdAt;
  String updatedAt;
  int patientId;
  int userId;
  int hospitalId;
  int doctorId;
  Null createdBy;
  Null updatedBy;
  FamilyMember familyMember;
  User userinfo;
  Doctorinfo doctorinfo;
  Profilefile profilefile;

  AppointmentEntity(
      {this.id,
      this.speciality,
      this.email,
      this.phone,
      this.timerange,
      this.remarks,
      this.status,
      this.appointDate,
      this.startappointdate,
      this.endappointdate,
      this.instructions,
      this.paymentStatus,
      this.isCarecashUsed,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.userId,
      this.hospitalId,
      this.doctorId,
      this.createdBy,
      this.updatedBy,
      this.familyMember,
      this.userinfo,
      this.doctorinfo,
      this.profilefile});

  AppointmentEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    speciality = json['speciality'];
    email = json['email'];
    phone = json['phone'];
    timerange = json['timerange'];
    remarks = json['remarks'];
    status = json['status'];
    appointDate = json['appointDate'];
    startappointdate = json['startappointdate'];
    endappointdate = json['endappointdate'];
    instructions = json['instructions'];
    paymentStatus = json['payment_status'];
    isCarecashUsed = json['is_carecash_used'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    familyMember = json['family_member'] != null
        ? new FamilyMember.fromJson(json['family_member'])
        : null;
    userinfo =
        json['userinfo'] != null ? new User.fromJson(json['userinfo']) : null;
    doctorinfo = json['doctorinfo'] != null
        ? new Doctorinfo.fromJson(json['doctorinfo'])
        : null;
    profilefile = json['profilefile'] != null
        ? new Profilefile.fromJson(json['profilefile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['speciality'] = this.speciality;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['timerange'] = this.timerange;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['appointDate'] = this.appointDate;
    data['startappointdate'] = this.startappointdate;
    data['endappointdate'] = this.endappointdate;
    data['instructions'] = this.instructions;
    data['payment_status'] = this.paymentStatus;
    data['is_carecash_used'] = this.isCarecashUsed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['doctor_id'] = this.doctorId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.familyMember != null) {
      data['family_member'] = this.familyMember.toJson();
    }
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    if (this.doctorinfo != null) {
      data['doctorinfo'] = this.doctorinfo.toJson();
    }
    if (this.profilefile != null) {
      data['profilefile'] = this.profilefile.toJson();
    }
    return data;
  }

//   @override
//   List<Object> get props => [
//         id,
//         speciality,
//         timerange,
//         email,
//         phone,
//         paymentStatus,
//         doctorinfo,
//         userinfo,
//         familyMember
//       ];
// }
}

class Doctorinfo {
  int id;
  String name;
  String firstname;
  String lastname;
  String email;
  String phone;
  String degree;
  String specialist;
  String experience;
  int fees;
  String gender;
  String address;
  String profilePic;
  bool verify;
  bool isaccount;
  String createdAt;
  String updatedAt;
  int loginId;
  Null createdBy;
  Null updatedBy;

  Doctorinfo(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.degree,
      this.specialist,
      this.experience,
      this.fees,
      this.gender,
      this.address,
      this.profilePic,
      this.verify,
      this.isaccount,
      this.createdAt,
      this.updatedAt,
      this.loginId,
      this.createdBy,
      this.updatedBy});

  Doctorinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    degree = json['degree'];
    specialist = json['specialist'];
    experience = json['experience'];
    fees = json['fees'];
    gender = json['gender'];
    address = json['address'];
    profilePic = json['profile_pic'];
    verify = json['verify'];
    isaccount = json['isaccount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    loginId = json['loginId'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['degree'] = this.degree;
    data['specialist'] = this.specialist;
    data['experience'] = this.experience;
    data['fees'] = this.fees;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['profile_pic'] = this.profilePic;
    data['verify'] = this.verify;
    data['isaccount'] = this.isaccount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['loginId'] = this.loginId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Profilefile {
  int id;
  int uploadFileId;
  int relatedId;
  String relatedType;
  String field;
  int order;
  String createdAt;
  String updatedAt;
  String name;
  Null alternativeText;
  Null caption;
  Null width;
  Null height;
  Null formats;
  String hash;
  String ext;
  String mime;
  String size;
  String url;
  String previewUrl;
  String provider;
  Null providerMetadata;
  int createdBy;
  int updatedBy;
  int morphsid;

  Profilefile(
      {this.id,
      this.uploadFileId,
      this.relatedId,
      this.relatedType,
      this.field,
      this.order,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url,
      this.previewUrl,
      this.provider,
      this.providerMetadata,
      this.createdBy,
      this.updatedBy,
      this.morphsid});

  Profilefile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadFileId = json['upload_file_id'];
    relatedId = json['related_id'];
    relatedType = json['related_type'];
    field = json['field'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats = json['formats'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    providerMetadata = json['provider_metadata'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    morphsid = json['morphsid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upload_file_id'] = this.uploadFileId;
    data['related_id'] = this.relatedId;
    data['related_type'] = this.relatedType;
    data['field'] = this.field;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    data['formats'] = this.formats;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    data['provider_metadata'] = this.providerMetadata;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['morphsid'] = this.morphsid;
    return data;
  }
}

class ServiceEntity extends Equatable {
  final int id;
  final String service;
  final String remarks;
  final String bookingdate;
  final String startbookingdate;
  final String endbookingdate;
  final String specialist_type;
  final String provider;
  final String timerange;

  ServiceEntity(
      {@required this.id,
      @required this.service,
      @required this.remarks,
      @required this.bookingdate,
      @required this.startbookingdate,
      @required this.endbookingdate,
      @required this.specialist_type,
      @required this.provider,
      @required this.timerange});

  @override
  List<Object> get props => [id, service, timerange];
}

class Service {
  int id;
  String service;
  String email;
  String phone;
  String timerange;
  String remarks;
  String bookingdate;
  String startbookingdate;
  String endbookingdate;
  int status;
  String createdAt;
  String updatedAt;
  int patientId;
  int userId;
  int serviceproviderId;
  // Null createdBy;
  // Null updatedBy;
  Memberinfo memberinfo;
  Usersinfo usersinfo;
  Providerinfo providerinfo;

  Service(
      {this.id,
      this.service,
      this.email,
      this.phone,
      this.timerange,
      this.remarks,
      this.bookingdate,
      this.startbookingdate,
      this.endbookingdate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.userId,
      this.serviceproviderId,
      // this.createdBy,
      // this.updatedBy,
      this.memberinfo,
      this.usersinfo,
      this.providerinfo});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    email = json['email'];
    phone = json['phone'];
    timerange = json['timerange'];
    remarks = json['remarks'];
    bookingdate = json['bookingdate'];
    startbookingdate = json['startbookingdate'];
    endbookingdate = json['endbookingdate'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    userId = json['user_id'];
    serviceproviderId = json['serviceprovider_id'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
    memberinfo = json['memberinfo'] != null
        ? new Memberinfo.fromJson(json['memberinfo'])
        : null;
    usersinfo = json['usersinfo'] != null
        ? new Usersinfo.fromJson(json['usersinfo'])
        : null;
    providerinfo = json['providerinfo'] != null
        ? new Providerinfo.fromJson(json['providerinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service'] = this.service;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['timerange'] = this.timerange;
    data['remarks'] = this.remarks;
    data['bookingdate'] = this.bookingdate;
    data['startbookingdate'] = this.startbookingdate;
    data['endbookingdate'] = this.endbookingdate;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['user_id'] = this.userId;
    data['serviceprovider_id'] = this.serviceproviderId;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    if (this.memberinfo != null) {
      data['memberinfo'] = this.memberinfo.toJson();
    }
    if (this.usersinfo != null) {
      data['usersinfo'] = this.usersinfo.toJson();
    }
    if (this.providerinfo != null) {
      data['providerinfo'] = this.providerinfo.toJson();
    }
    return data;
  }
}

class Memberinfo {
  int id;
  String name;
  String relation;
  String dob;
  String gender;
  String email;
  String address;
  // Null emergencyCountryCode;
  String emergencyContactNo;
  String emergencyContactPerson;
  String profilePic;
  String phone;
  // Null customerId;
  // Null otp;
  int verify;
  int userPackageMapping;
  String createdAt;
  String updatedAt;
  // Null createdBy;
  // Null updatedBy;

  Memberinfo({
    this.id,
    this.name,
    this.relation,
    this.dob,
    this.gender,
    this.email,
    this.address,
    // this.emergencyCou/ntryCode,
    this.emergencyContactNo,
    this.emergencyContactPerson,
    this.profilePic,
    this.phone,
    // this.customerId,
    // this.otp,
    this.verify,
    this.userPackageMapping,
    this.createdAt,
    this.updatedAt,
    // this.createdBy,
    // this.updatedBy,
  });

  Memberinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    address = json['address'];
    // emergencyCountryCode/ = json['emergency_country_code'];
    emergencyContactNo = json['emergency_contact_no'];
    emergencyContactPerson = json['emergency_contact_person'];
    profilePic = json['profile_pic'];
    phone = json['phone'];
    // customerId = json['customer_id'];
    // otp = json['otp'];
    verify = json['verify'];
    userPackageMapping = json['user_package_mapping'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['address'] = this.address;
    // data['emergency_country_code'] = this.emergencyCountryCode;
    data['emergency_contact_no'] = this.emergencyContactNo;
    data['emergency_contact_person'] = this.emergencyContactPerson;
    data['profile_pic'] = this.profilePic;
    data['phone'] = this.phone;
    // data['customer_id'] = this.customerId;
    // data['otp'] = this.otp;
    data['verify'] = this.verify;
    data['user_package_mapping'] = this.userPackageMapping;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Usersinfo {
  int id;
  String username;
  String email;
  String provider;
  String password;
  String resetPasswordToken;
  bool confirmed;
  bool blocked;
  String name;
  String phoneNumber;
  String profilephoto;
  String country;
  // Null user;
  String address;
  String credits;
  String createdAt;
  String updatedAt;
  // Null createdBy;
  // Null updatedBy;
  int role;

  Usersinfo(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.password,
      this.resetPasswordToken,
      this.confirmed,
      this.blocked,
      this.name,
      this.phoneNumber,
      this.profilephoto,
      this.country,
      // this.user,
      this.address,
      this.credits,
      this.createdAt,
      this.updatedAt,
      // this.createdBy,
      // this.updatedBy,
      this.role});

  Usersinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    password = json['password'];
    resetPasswordToken = json['resetPasswordToken'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    profilephoto = json['profilephoto'];
    country = json['country'];
    // user = json['user'];
    address = json['address'];
    credits = json['credits'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['password'] = this.password;
    data['resetPasswordToken'] = this.resetPasswordToken;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['profilephoto'] = this.profilephoto;
    data['country'] = this.country;
    // data['user'] = this.user;
    data['address'] = this.address;
    data['credits'] = this.credits;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.update / dBy;
    data['role'] = this.role;
    return data;
  }
}

class Providerinfo {
  int id;
  String name;
  String phone;
  String address;
  String service;
  int workinghours;
  String description;
  bool status;
  String createdAt;
  String updatedAt;
  // Null createdBy;
  // Null updatedBy;

  Providerinfo({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.service,
    this.workinghours,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.createdBy,
    // this.updatedBy,
  });

  Providerinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    service = json['service'];
    workinghours = json['workinghours'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['service'] = this.service;
    data['workinghours'] = this.workinghours;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}
