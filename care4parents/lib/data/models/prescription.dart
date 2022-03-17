class PrescriptionMain {
  Drprescription drprescription;
  List<Prescription> drprescriptionmedicine;
  List<Immunization> immunization;
  int drapproval;

  PrescriptionMain(
      {this.drprescription,
      this.drprescriptionmedicine,
      this.immunization,
      this.drapproval});

  PrescriptionMain.fromJson(Map<String, dynamic> json) {
    drprescription = json['drprescription'] != null
        ? new Drprescription.fromJson(json['drprescription'])
        : null;
    if (json['drprescriptionmedicine'] != null) {
      drprescriptionmedicine = new List<Prescription>();
      json['drprescriptionmedicine'].forEach((v) {
        drprescriptionmedicine.add(new Prescription.fromJson(v));
      });
    }
    if (json['immunization'] != null) {
      immunization = new List<Immunization>();
      json['immunization'].forEach((v) {
        immunization.add(new Immunization.fromJson(v));
      });
    }
    drapproval = json['drapproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drprescription != null) {
      data['drprescription'] = this.drprescription.toJson();
    }
    if (this.drprescriptionmedicine != null) {
      data['drprescriptionmedicine'] =
          this.drprescriptionmedicine.map((v) => v.toJson()).toList();
    }
    if (this.immunization != null) {
      data['immunization'] = this.immunization.map((v) => v.toJson()).toList();
    }
    data['drapproval'] = this.drapproval;
    return data;
  }
}

class Drprescription {
  int id;
  int appointmentId;
  String remarks;
  int status;
  int drapproval;
  String createdAt;
  String updatedAt;
  int patientId;

  Drprescription(
      {this.id,
      this.appointmentId,
      this.remarks,
      this.status,
      this.drapproval,
      this.createdAt,
      this.updatedAt,
      this.patientId});

  Drprescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointmentId'];
    remarks = json['remarks'];
    status = json['status'];
    drapproval = json['drapproval'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointmentId'] = this.appointmentId;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['drapproval'] = this.drapproval;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    return data;
  }
}

class Prescription {
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
  // Null createdBy;
  // Null updatedBy;
  Medicineinfo medicineinfo;

  Prescription(
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
      // this.createdBy,
      // this.updatedBy,
      this.medicineinfo});

  Prescription.fromJson(Map<String, dynamic> json) {
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
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
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
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
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
  // Null createdBy;
  // Null updatedBy;

  Medicineinfo({
    this.id,
    this.name,
    this.introduction,
    this.uses,
    this.benefits,
    this.sideEffects,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.createdBy,
    // this.updatedBy,
  });

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
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
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
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Immunization {
  int id;
  int approveDocId;
  String name;
  String intake;
  String remarks;
  String startDate;
  String endDate;
  String route;
  String prescriptionFile;
  bool status;
  String createdAt;
  String updatedAt;
  int patientId;
  int appointmentId;
  int drprescriptionId;
  // Null createdBy;
  // Null updatedBy;

  Immunization(
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
      // this.createdBy,
      // this.updatedBy,
      });

  Immunization.fromJson(Map<String, dynamic> json) {
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
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
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
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}