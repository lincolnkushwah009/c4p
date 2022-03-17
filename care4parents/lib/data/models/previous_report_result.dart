import 'package:care4parents/data/models/family_member.dart';

class PreviousReportResult {
  List<PreviousReport> data;
  int total;
  int page;
  int limit;

  PreviousReportResult({this.data, this.total, this.page, this.limit});

  PreviousReportResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PreviousReport>();
      json['data'].forEach((v) {
        data.add(new PreviousReport.fromJson(v));
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

class PreviousReport {
  int id;
  // Null drname;
  String reportType;
  String dateOfTest;
  String link;
  String reportFile;
  String createdAt;
  String updatedAt;
  int familyMemberId;
  // Null createdBy;
  // Null updatedBy;
  FamilyMember familyMember;
  Reportfile reportfile;

  PreviousReport(
      {this.id,
      // this.drname,
      this.reportType,
      this.dateOfTest,
      this.link,
      this.reportFile,
      this.createdAt,
      this.updatedAt,
      this.familyMemberId,
      // this.createdBy,
      // this.updatedBy,
      this.familyMember,
      this.reportfile});

  PreviousReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // drname = json['drname'];
    reportType = json['report_type'];
    dateOfTest = json['date_of_test'];
    link = json['link'];
    reportFile = json['report_file'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    familyMemberId = json['family_member_id'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
    familyMember = json['family_member'] != null
        ? new FamilyMember.fromJson(json['family_member'])
        : null;
    reportfile = json['reportfile'] != null
        ? new Reportfile.fromJson(json['reportfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['drname'] = this.drname;
    data['report_type'] = this.reportType;
    data['date_of_test'] = this.dateOfTest;
    data['link'] = this.link;
    data['report_file'] = this.reportFile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['family_member_id'] = this.familyMemberId;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    if (this.familyMember != null) {
      data['family_member'] = this.familyMember.toJson();
    }
    if (this.reportfile != null) {
      data['reportfile'] = this.reportfile.toJson();
    }
    return data;
  }
}

class Reportfile {
  int id;
  int uploadFileId;
  int relatedId;
  String relatedType;
  String field;
  int order;
  String createdAt;
  String updatedAt;
  String name;
  // Null alternativeText;
  // Null caption;
  // Null width;
  // Null height;
  // Null formats;
  String hash;
  String ext;
  String mime;
  String size;
  String url;
  String previewUrl;
  String provider;
  // Null providerMetadata;
  int createdBy;
  int updatedBy;
  int morphsid;

  Reportfile(
      {this.id,
      this.uploadFileId,
      this.relatedId,
      this.relatedType,
      this.field,
      this.order,
      this.createdAt,
      this.updatedAt,
      this.name,
      // this.alternativeText,
      // this.caption,
      // this.width,
      // this.height,
      // this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url,
      this.previewUrl,
      this.provider,
      // this.providerMetadata,
      this.createdBy,
      this.updatedBy,
      this.morphsid});

  Reportfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadFileId = json['upload_file_id'];
    relatedId = json['related_id'];
    relatedType = json['related_type'];
    field = json['field'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    // alternativeText = json['alternativeText'];
    // caption = json['caption'];
    // width = json['width'];
    // height = json['height'];
    // formats = json['formats'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    // providerMetadata = json['provider_metadata'];
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
    // data['alternativeText'] = this.alternativeText;
    // data['caption'] = this.caption;
    // data['width'] = this.width;
    // data['height'] = this.height;
    // data['formats'] = this.formats;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    // data['provider_metadata'] = this.providerMetadata;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['morphsid'] = this.morphsid;
    return data;
  }
}
