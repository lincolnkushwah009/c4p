// import 'package:care4parents/domain/entities/appointment_entity.dart';
// import 'package:intl/intl.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'appointment_model.g.dart';

// @JsonSerializable()
// class AppointmentModel extends AppointmentEntity {
//   final int id;
//   final String speciality;
//   final String remarks;
//   final String appointDate;
//   final String startappointdate;
//   final String endappointdate;
//   final String specialist_type;
//   final String timerange;

//   AppointmentModel(
//       {this.id,
//       this.speciality,
//       this.remarks,
//       this.appointDate,
//       this.startappointdate,
//       this.specialist_type,
//       this.timerange,
//       this.endappointdate});

//   @override
//   String toString() =>
//       'Appointment Model String Json { id: $id, speciality: $speciality, appointDate: $appointDate, timerange $timerange}';
//   factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
//       _$AppointmentModelFromJson(json);
//   Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
// }

import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';

import 'family_member.dart';

class AppointmentModel {
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
  // Null instructions;
  // Null paymentStatus;
  // Null isCarecashUsed;
  String createdAt;
  String updatedAt;
  int patientId;
  int userId;
  int hospitalId;
  int doctorId;
  // Null createdBy;
  // Null updatedBy;
  FamilyMember familyMember;
  User userinfo;
  Doctorinfo doctorinfo;
  Profilefile profilefile;

  AppointmentModel(
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
      // this.instructions,
      // this.paymentStatus,
      // this.isCarecashUsed,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.userId,
      this.hospitalId,
      this.doctorId,
      // this.createdBy,
      // this.updatedBy,
      this.familyMember,
      this.userinfo,
      this.doctorinfo,
      this.profilefile});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
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
    // instructions = json['instructions'];
    // paymentStatus = json['payment_status'];
    // isCarecashUsed = json['is_carecash_used'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
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
    // data['instructions'] = this.instructions;
    // data['payment_status'] = this.paymentStatus;
    // data['is_carecash_used'] = this.isCarecashUsed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['doctor_id'] = this.doctorId;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
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
}

// class Doctorinfo {
//   int id;
//   String name;
//   String firstname;
//   String lastname;
//   String email;
//   String phone;
//   String degree;
//   String specialist;
//   String experience;
//   int fees;
//   String gender;
//   String address;
//   String profilePic;
//   bool verify;
//   Null isaccount;
//   String createdAt;
//   String updatedAt;
//   int loginId;
//   Null createdBy;
//   Null updatedBy;

//   Doctorinfo(
//       {this.id,
//       this.name,
//       this.firstname,
//       this.lastname,
//       this.email,
//       this.phone,
//       this.degree,
//       this.specialist,
//       this.experience,
//       this.fees,
//       this.gender,
//       this.address,
//       this.profilePic,
//       this.verify,
//       this.isaccount,
//       this.createdAt,
//       this.updatedAt,
//       this.loginId,
//       this.createdBy,
//       this.updatedBy});

//   Doctorinfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     email = json['email'];
//     phone = json['phone'];
//     degree = json['degree'];
//     specialist = json['specialist'];
//     experience = json['experience'];
//     fees = json['fees'];
//     gender = json['gender'];
//     address = json['address'];
//     profilePic = json['profile_pic'];
//     verify = json['verify'];
//     isaccount = json['isaccount'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     loginId = json['loginId'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['firstname'] = this.firstname;
//     data['lastname'] = this.lastname;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['degree'] = this.degree;
//     data['specialist'] = this.specialist;
//     data['experience'] = this.experience;
//     data['fees'] = this.fees;
//     data['gender'] = this.gender;
//     data['address'] = this.address;
//     data['profile_pic'] = this.profilePic;
//     data['verify'] = this.verify;
//     data['isaccount'] = this.isaccount;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['loginId'] = this.loginId;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     return data;
//   }
// }

// class Profilefile {
//   int id;
//   int uploadFileId;
//   int relatedId;
//   String relatedType;
//   String field;
//   int order;
//   String createdAt;
//   String updatedAt;
//   String name;
//   Null alternativeText;
//   Null caption;
//   Null width;
//   Null height;
//   Null formats;
//   String hash;
//   String ext;
//   String mime;
//   String size;
//   String url;
//   String previewUrl;
//   String provider;
//   Null providerMetadata;
//   int createdBy;
//   int updatedBy;
//   int morphsid;

//   Profilefile(
//       {this.id,
//       this.uploadFileId,
//       this.relatedId,
//       this.relatedType,
//       this.field,
//       this.order,
//       this.createdAt,
//       this.updatedAt,
//       this.name,
//       this.alternativeText,
//       this.caption,
//       this.width,
//       this.height,
//       this.formats,
//       this.hash,
//       this.ext,
//       this.mime,
//       this.size,
//       this.url,
//       this.previewUrl,
//       this.provider,
//       this.providerMetadata,
//       this.createdBy,
//       this.updatedBy,
//       this.morphsid});

//   Profilefile.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uploadFileId = json['upload_file_id'];
//     relatedId = json['related_id'];
//     relatedType = json['related_type'];
//     field = json['field'];
//     order = json['order'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     name = json['name'];
//     alternativeText = json['alternativeText'];
//     caption = json['caption'];
//     width = json['width'];
//     height = json['height'];
//     formats = json['formats'];
//     hash = json['hash'];
//     ext = json['ext'];
//     mime = json['mime'];
//     size = json['size'];
//     url = json['url'];
//     previewUrl = json['previewUrl'];
//     provider = json['provider'];
//     providerMetadata = json['provider_metadata'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     morphsid = json['morphsid'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['upload_file_id'] = this.uploadFileId;
//     data['related_id'] = this.relatedId;
//     data['related_type'] = this.relatedType;
//     data['field'] = this.field;
//     data['order'] = this.order;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['name'] = this.name;
//     data['alternativeText'] = this.alternativeText;
//     data['caption'] = this.caption;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     data['formats'] = this.formats;
//     data['hash'] = this.hash;
//     data['ext'] = this.ext;
//     data['mime'] = this.mime;
//     data['size'] = this.size;
//     data['url'] = this.url;
//     data['previewUrl'] = this.previewUrl;
//     data['provider'] = this.provider;
//     data['provider_metadata'] = this.providerMetadata;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['morphsid'] = this.morphsid;
//     return data;
//   }
// }
