import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/previous_report_result.dart';
import 'package:care4parents/data/models/report_detail.dart';

class ActivityMainResult {
  List<ActivityResult> data;
  int total;
  int page;
  int limit;

  ActivityMainResult({this.data, this.total, this.page, this.limit});

  ActivityMainResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ActivityResult>();
      json['data'].forEach((v) {
        data.add(new ActivityResult.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class ActivityResult {
  int id;
  String scheduleDate;
  String executionDate;
  String code;
  String status;
  String link;
  String type;
  String description;
  String activityReportFile;
  String createdAt;
  String updatedAt;
  int familyMember;
  int service;
  List<VitalVal> vitalVals;
  // String createdBy;
  // String updatedBy;
  Services services;
  FamilyMember familyMembers;
  Reportfile reportfile;

  ActivityResult(
      {this.id,
      this.scheduleDate,
      this.executionDate,
      this.code,
      this.status,
      this.link,
      this.type,
      this.description,
      this.activityReportFile,
      this.createdAt,
      this.updatedAt,
      this.familyMember,
      this.service,
      this.vitalVals,
      // this.updatedBy,
      this.services,
      this.familyMembers,
      this.reportfile});

  ActivityResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleDate = json['schedule_date'];
    executionDate = json['execution_date'];
    code = json['code'];
    status = json['status'];
    link = json['link'];
    type = json['type'];
    description = json['description'];
    activityReportFile = json['activity_report_file'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    familyMember = json['family_member'];
    service = json['service'];
    if (json['vitalVals'] != null) {
      vitalVals = new List<VitalVal>();
      json['vitalVals'].forEach((v) {
        vitalVals.add(new VitalVal.fromJson(v));
      });
    }

    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
    familyMembers = json['family_members'] != null
        ? new FamilyMember.fromJson(json['family_members'])
        : null;
    reportfile = json['reportfile'] != null
        ? new Reportfile.fromJson(json['reportfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schedule_date'] = this.scheduleDate;
    data['execution_date'] = this.executionDate;
    data['code'] = this.code;
    data['status'] = this.status;
    data['link'] = this.link;
    data['type'] = this.type;
    data['description'] = this.description;
    data['activity_report_file'] = this.activityReportFile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['family_member'] = this.familyMember;
    data['service'] = this.service;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    if (this.services != null) {
      data['services'] = this.services.toJson();
    }
    if (this.familyMembers != null) {
      data['family_members'] = this.familyMembers.toJson();
    }
    if (this.reportfile != null) {
      data['reportfile'] = this.reportfile.toJson();
    }
    return data;
  }
}

class Services {
  int id;
  String name;
  String description;
  String code;
  String type;
  bool status;
  String createdAt;
  String updatedAt;
  // Null createdBy;
  // Null updatedBy;

  Services({
    this.id,
    this.name,
    this.description,
    this.code,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.createdBy,
    // this.updatedBy
  });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    type = json['type'];
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
    data['description'] = this.description;
    data['code'] = this.code;
    data['type'] = this.type;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}

// class FamilyMembers {
//   int id;
//   String name;
//   String relation;
//   String dob;
//   String gender;
//   String email;
//   String address;
//   Null emergencyCountryCode;
//   String emergencyContactNo;
//   String emergencyContactPerson;
//   String profilePic;
//   String phone;
//   String customerId;
//   String otp;
//   int verify;
//   int userPackageMapping;
//   String createdAt;
//   String updatedAt;
//   String createdBy;
//   String updatedBy;

//   FamilyMembers(
//       {this.id,
//       this.name,
//       this.relation,
//       this.dob,
//       this.gender,
//       this.email,
//       this.address,
//       this.emergencyCountryCode,
//       this.emergencyContactNo,
//       this.emergencyContactPerson,
//       this.profilePic,
//       this.phone,
//       this.customerId,
//       this.otp,
//       this.verify,
//       this.userPackageMapping,
//       this.createdAt,
//       this.updatedAt,
//       this.createdBy,
//       this.updatedBy});

//   FamilyMembers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     relation = json['relation'];
//     dob = json['dob'];
//     gender = json['gender'];
//     email = json['email'];
//     address = json['address'];
//     emergencyCountryCode = json['emergency_country_code'];
//     emergencyContactNo = json['emergency_contact_no'];
//     emergencyContactPerson = json['emergency_contact_person'];
//     profilePic = json['profile_pic'];
//     phone = json['phone'];
//     customerId = json['customer_id'];
//     otp = json['otp'];
//     verify = json['verify'];
//     userPackageMapping = json['user_package_mapping'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['relation'] = this.relation;
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['emergency_country_code'] = this.emergencyCountryCode;
//     data['emergency_contact_no'] = this.emergencyContactNo;
//     data['emergency_contact_person'] = this.emergencyContactPerson;
//     data['profile_pic'] = this.profilePic;
//     data['phone'] = this.phone;
//     data['customer_id'] = this.customerId;
//     data['otp'] = this.otp;
//     data['verify'] = this.verify;
//     data['user_package_mapping'] = this.userPackageMapping;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     return data;
//   }
// }
