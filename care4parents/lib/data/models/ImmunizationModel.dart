class ImmunizationModel {
  List<ImmunizationData> data;
  int total;
  int page;
  int limit;
  String fm_count;

  ImmunizationModel({this.data, this.total, this.page, this.limit,this.fm_count});

  ImmunizationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ImmunizationData>();
      json['data'].forEach((v) {
        data.add(new ImmunizationData.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }
  ImmunizationModel.fromPPcountJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    //   data = new List<ImmunizationData>();
    //   json['data'].forEach((v) {
    //     data.add(new ImmunizationData.fromJson(v));
    //   });
    // }

    fm_count = json['fm_count'].toString();
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

class ImmunizationData {
  int id;
  int approveDocId;
  String name;
  Null intake;
  String remarks;
  String startDate;
  Null endDate;
  String route;
  String prescriptionFile;
  bool status;
  String createdAt;
  String updatedAt;
  int patientId;
  int appointmentId;
  int drprescriptionId;
  Null createdBy;
  Null updatedBy;

  ImmunizationData(
      {this.id,
        this.approveDocId,
        this.name,
        this.intake,
        this.remarks,
        this.startDate,
        this.endDate,
        this.route,
        this.prescriptionFile,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.patientId,
        this.appointmentId,
        this.drprescriptionId,
        this.createdBy,
        this.updatedBy});

  ImmunizationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approveDocId = json['approve_doc_id'];
    name = json['name'];
    intake = json['intake'];
    remarks = json['remarks'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    route = json['route'];
    prescriptionFile = json['prescription_file'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    appointmentId = json['appointmentId'];
    drprescriptionId = json['drprescriptionId'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['approve_doc_id'] = this.approveDocId;
    data['name'] = this.name;
    data['intake'] = this.intake;
    data['remarks'] = this.remarks;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['route'] = this.route;
    data['prescription_file'] = this.prescriptionFile;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['appointmentId'] = this.appointmentId;
    data['drprescriptionId'] = this.drprescriptionId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}