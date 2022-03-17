class MedicineModel {
  List<MedicineData> data;
  int total;
  int page;
  int limit;

  MedicineModel({this.data, this.total, this.page, this.limit});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MedicineData>();
      json['data'].forEach((v) {
        data.add(new MedicineData.fromJson(v));
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

class MedicineData {
  int id;
  int approveDocId;
  String intake;
  bool premorning;
  bool morning;
  bool afternoon;
  bool evening;
  bool bedtime;
  String remarks;
  String startDate;
  String endDate;
  int totalDay;
  String route;
  String prescriptionFile;
  bool status;
  String createdAt;
  String updatedAt;
  int patientId;
  int appointmentId;
  int medicineId;
  int drprescriptionId;
  Null createdBy;
  Null updatedBy;
  Medicineinfo medicineinfo;

  MedicineData(
      {this.id,
        this.approveDocId,
        this.intake,
        this.premorning,
        this.morning,
        this.afternoon,
        this.evening,
        this.bedtime,
        this.remarks,
        this.startDate,
        this.endDate,
        this.totalDay,
        this.route,
        this.prescriptionFile,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.patientId,
        this.appointmentId,
        this.medicineId,
        this.drprescriptionId,
        this.createdBy,
        this.updatedBy,
        this.medicineinfo});

  MedicineData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    approveDocId = json['approve_doc_id'];
    intake = json['intake'];
    premorning = json['premorning'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];
    bedtime = json['bedtime'];
    remarks = json['remarks'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalDay = json['totalDay'];
    route = json['route'];
    prescriptionFile = json['prescription_file'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    appointmentId = json['appointmentId'];
    medicineId = json['medicineId'];
    drprescriptionId = json['drprescriptionId'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    medicineinfo = json['medicineinfo'] != null
        ? new Medicineinfo.fromJson(json['medicineinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['approve_doc_id'] = this.approveDocId;
    data['intake'] = this.intake;
    data['premorning'] = this.premorning;
    data['morning'] = this.morning;
    data['afternoon'] = this.afternoon;
    data['evening'] = this.evening;
    data['bedtime'] = this.bedtime;
    data['remarks'] = this.remarks;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['totalDay'] = this.totalDay;
    data['route'] = this.route;
    data['prescription_file'] = this.prescriptionFile;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['appointmentId'] = this.appointmentId;
    data['medicineId'] = this.medicineId;
    data['drprescriptionId'] = this.drprescriptionId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.medicineinfo != null) {
      data['medicineinfo'] = this.medicineinfo.toJson();
    }
    return data;
  }
}

class Medicineinfo {
  int id;
  String name;
  String introduction;
  String uses;
  String benefits;
  String sideEffects;
  bool status;
  String createdAt;
  String updatedAt;
  Null createdBy;
  Null updatedBy;

  Medicineinfo(
      {this.id,
        this.name,
        this.introduction,
        this.uses,
        this.benefits,
        this.sideEffects,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy});

  Medicineinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    introduction = json['introduction'];
    uses = json['uses'];
    benefits = json['benefits'];
    sideEffects = json['sideEffects'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['introduction'] = this.introduction;
    data['uses'] = this.uses;
    data['benefits'] = this.benefits;
    data['sideEffects'] = this.sideEffects;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}