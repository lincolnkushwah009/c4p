import 'package:equatable/equatable.dart';

class TypeParams extends Equatable {
  final String mobile;
  final String type;
  final String startdate;
  final String enddate;
  final String datetype;

  TypeParams(
      {this.mobile, this.type, this.startdate, this.enddate, this.datetype});

  @override
  List<Object> get props => [mobile, type, startdate, enddate, datetype];
  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "type": type,
        "startdate": startdate,
        "enddate": enddate,
        "datetype": datetype,
      };
}

class ServiceUploadParams extends Equatable {
  final String member_name;
  final String member_phone;
  final String report_date;
  final int service;
  final int family_member;
  final String document;

  ServiceUploadParams(
      {this.member_name,
      this.member_phone,
      this.report_date,
      this.service,
      this.family_member,
      this.document});

  @override
  List<Object> get props => [
        member_name,
        member_phone,
        report_date,
        service,
        family_member,
        document
      ];
  Map<String, dynamic> toJson() => {
        "member_name": member_name,
        "member_phone": member_phone,
        "report_date": report_date,
        "service": service,
        "family_member": family_member,
        "document": document
      };
}
