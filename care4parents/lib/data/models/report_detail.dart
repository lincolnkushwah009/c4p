import 'dart:convert';

import 'dart:developer';

class ReportDetail {
  List<Data> data;
  MasterKeyLabels masterKeyLabels;

  int page;
  int limit;

  ReportDetail({this.data, this.masterKeyLabels, this.page, this.limit});

  ReportDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    masterKeyLabels = json['master_key_labels'] != null
        ? new MasterKeyLabels.fromJson(json['master_key_labels'])
        : null;
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.masterKeyLabels != null) {
      data['master_key_labels'] = this.masterKeyLabels.toJson();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class Data {
  int id;
  String reportLab;
  String vitalType;
  VitalValue vitalValue;
  bool isApproved;
  String createdAt;
  String updatedAt;
  int patientId;
  int memberServiceMappingId;
  int ocrRawId;
  // Null createdBy;
  // Null updatedBy;
  OcrRaw ocrRaw;

  Data(
      {this.id,
      this.reportLab,
      this.vitalType,
      this.vitalValue,
      this.isApproved,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.memberServiceMappingId,
      this.ocrRawId,
      this.ocrRaw
      // this.createdBy,
      // this.updatedBy
      });

  List<VitalVal> data = List();
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['report_lab'] != null) reportLab = json['report_lab'];
    vitalType = json['vital_type'];
    vitalValue = new VitalValue.fromJson(json['vital_value']);
    isApproved = json['is_approved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patient_id'];
    memberServiceMappingId = json['member_service_mapping_id'];
    ocrRawId = json['ocr_raw_id'];
    ocrRaw =
        json['ocr_raw'] != null ? new OcrRaw.fromJson(json['ocr_raw']) : null;
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['report_lab'] = this.reportLab;
    data['vital_type'] = this.vitalType;
    // if (this.vitalValue != null) {
    // print
    // print('this.vitalValue' + this.vitalValue.toString());
    data['vital_value'] = jsonEncode(this.vitalValue);

    // }
    data['is_approved'] = this.isApproved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patient_id'] = this.patientId;
    data['member_service_mapping_id'] = this.memberServiceMappingId;
    data['ocr_raw_id'] = this.ocrRawId;
    if (this.ocrRaw != null) {
      data['ocr_raw'] = this.ocrRaw.toJson();
    }
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    return data;
  }
}

class OcrRaw {
  int id;
  List<String> raw;
  String reportLab;
  String reportDate;
  String createdAt;
  String updatedAt;
  int patientId;
  int createdBy;
  int updatedBy;
  int memberServiceMappingId;

  OcrRaw(
      {this.id,
      this.raw,
      this.reportLab,
      this.reportDate,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.createdBy,
      this.updatedBy,
      this.memberServiceMappingId});

  OcrRaw.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    raw = json['raw'].cast<String>();
    reportLab = json['report_lab'];
    reportDate = json['report_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patient_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    memberServiceMappingId = json['member_service_mapping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['raw'] = this.raw;
    data['report_lab'] = this.reportLab;
    data['report_date'] = this.reportDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patient_id'] = this.patientId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['member_service_mapping_id'] = this.memberServiceMappingId;
    return data;
  }
}

class MasterKeyLabels {
  List<Lab> labs = List();

  MasterKeyLabels({this.labs});

  MasterKeyLabels.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      List<LabTest> labTests = List();
      value.forEach((item) {
        labTests.add(LabTest(
          key: item['key'],
          label: item['label'],
        ));
      });

      labs.add(Lab(label: key, list: labTests));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.labs != null) {
      data['labs'] = this.labs.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Lab {
  String label;
  List<LabTest> list;

  Lab({this.label, this.list});

  Lab.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    list = json['list'];

    if (json['list'] != null) {
      list = new List<LabTest>();
      json['MaxLab'].forEach((v) {
        list.add(new LabTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;

    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabTest {
  String key;
  String label;

  LabTest({this.key, this.label});

  LabTest.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['label'] = this.label;
    return data;
  }
}

class VitalValue {
  List<VitalVal> data = List();
  VitalValue({this.data});

  VitalValue.fromJson(Map<String, dynamic> json) {
    log('json.toString() ====' + json.toString());
    json.forEach((key, value) {
      List<Test> test = List();
      value.forEach((item) {
        // print(item);
        // print(item['unique_key']);
        test.add(Test(
            unique_key: item['unique_key'],
            test: item['test'],
            value: item['value'],
            unit: (item['unit'] is String) ? item['unit'] : '',
            interval: item['interval']));
      });
      if (!test.isEmpty) {
        // print('test=====>' + test[0].unique_key);
      }
      data.add(VitalVal(vital_key: key, vital_value: test, show: false));
    });

    // data.forEach((element) {
    // print(element.vital_key + " : " + '${element.vital_value.length}');
    // });
  }

  Map<String, dynamic> toJson() {
    print('============toJson============');
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['vital_value'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VitalVal {
  String vital_key;
  String vital_label;
  List<Test> vital_value;
  bool show;

  VitalVal({this.vital_key, this.vital_label, this.vital_value, this.show});

  VitalVal.fromJson(Map<String, dynamic> json) {
    vital_key = json['vital_key'];
    vital_value = json['vital_value'];
    vital_label = json['vital_label'];
    show = json['show'] != null ? json['show'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vital_key'] = this.vital_key;
    data['vital_label'] = this.vital_label;
    data['show'] = this.show;
    this.vital_value = new List<Test>();
    data['vital_value'].forEach((v) {
      vital_value.add(new Test.fromJson(v));
    });
    ;
    return data;
  }
}

class Test {
  String unique_key;
  String test;
  String value;
  String unit;
  String interval;

  Test({this.unique_key, this.test, this.value, this.unit, this.interval});

  Test.fromJson(Map<String, dynamic> json) {
    unique_key = json['unique_key'];
    test = json['test'];
    value = json['value'];
    unit = json['unit'] is String ? json['unit'] : '';
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_key'] = this.unique_key;
    data['test'] = this.test;
    data['value'] = this.value;
    data['unit'] = (this.unit is String) ? this.unit : '';
    data['interval'] = this.interval;
    return data;
  }
}

class VitalValMain {
  String confirmation;
  List<DataMain> data;

  VitalValMain({this.confirmation, this.data});

  VitalValMain.fromJson(Map<String, dynamic> json) {
    confirmation = json['confirmation'];
    if (json['data'] != null) {
      data = new List<DataMain>();
      json['data'].forEach((v) {
        data.add(new DataMain.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmation'] = this.confirmation;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMain {
  String vitalKey;
  String vitalLabel;
  List<Test> vitalValue;
  String reportLab;
  String reportDate;
  int patientId;
  int memberServiceMappingId;
  bool isApproved;
  String createdAt;
  String updatedAt;

  DataMain(
      {this.vitalKey,
      this.vitalLabel,
      this.vitalValue,
      this.reportLab,
      this.reportDate,
      this.patientId,
      this.memberServiceMappingId,
      this.isApproved,
      this.createdAt,
      this.updatedAt});

  DataMain.fromJson(Map<String, dynamic> json) {
    vitalKey = json['vital_key'];
    vitalLabel = json['vital_label'];
    if (json['vital_value'] != null) {
      vitalValue = new List<Test>();
      json['vital_value'].forEach((v) {
        vitalValue.add(new Test.fromJson(v));
      });
    }
    reportLab = json['report_lab'];
    reportDate = json['report_date'];
    patientId = json['patient_id'];
    memberServiceMappingId = json['member_service_mapping_id'];
    isApproved = json['is_approved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vital_key'] = this.vitalKey;
    data['vital_label'] = this.vitalLabel;
    if (this.vitalValue != null) {
      data['vital_value'] = this.vitalValue.map((v) => v.toJson()).toList();
    }
    data['report_lab'] = this.reportLab;
    data['report_date'] = this.reportDate;
    data['patient_id'] = this.patientId;
    data['member_service_mapping_id'] = this.memberServiceMappingId;
    data['is_approved'] = this.isApproved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

// class VitalValueMain {
//   String test;
//   String value;
//   String unit;
//   String interval;

//   VitalValueMain({this.test, this.value, this.unit, this.interval});

//   VitalValueMain.fromJson(Map<String, dynamic> json) {
//     test = json['test'];
//     value = json['value'];
//     unit = json['unit'];
//     interval = json['interval'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['test'] = this.test;
//     data['value'] = this.value;
//     data['unit'] = this.unit;
//     data['interval'] = this.interval;
//     return data;
//   }
// }
