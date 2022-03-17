import 'dart:convert';

import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/data/models/activity_result.dart';

import 'package:care4parents/data/models/array_common_result.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/page_result.dart';
import 'package:care4parents/data/models/prescription.dart';
import 'package:care4parents/data/models/previous_report_result.dart';
import 'package:care4parents/data/models/report_detail.dart';
import 'package:care4parents/data/models/trend_main.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:dartz/dartz.dart';

abstract class OtherRemoteDataSource {
  Future<Either<AppError, ObjectCommonResult>> cancelAppointment(
      int appointment_id);
  Future<Either<AppError, PageResult>> getPage(String page_name);
  Future<Either<AppError, int>> getPaymentFees(int appointment_id);
  Future<Either<AppError, PResult>> updatePayment(RozorPayMappingParams razorpay_response);
  Future<Either<AppError, List<ActivityResult>>> getActivities(int member_id);
  Future<Either<AppError, List<ActivityResult>>> getReports(int member_id);
  Future<Either<AppError, ReportDetail>> getOcr(int member_id);
  Future<Either<AppError, List<DataMain>>> getOcrSearch(
      int member_id, String search);
  Future<Either<AppError, PrescriptionMain>> getPrescriptions(int id);
  Future<Either<AppError, List<PreviousReport>>> getPreviousReports(
      int member_id);
  Future<Either<AppError, TrendMain>> getTrend(
      int patient_id, String unique_key);
  Future<Either<AppError, List<Invoice>>> getInvoices();
  Future<Either<AppError, List<MedicineData>>> getMedicine(int member_id);
  Future<Either<AppError, List<ImmunizationData>>> getImmunization(
      int member_id);

  Future<Either<AppError, ImmunizationModel>> getUserFamilyppcount(
      int userId);
  Future<Either<AppError, List<MedicineData>>> getConference(int member_id);
  Future<Either<AppError, ObjectCommonResult>> uploadReport(
      ServiceUploadParams params);

  Future<Either<AppError, ObjectCommonResult>> userSos(
      User params);
  Future<Either<AppError, ObjectCommonResult>> purchagePlanPayment(
      PuechagePackageMappingParams params);
  Future<Either<AppError, ObjectCommonResult>> addCareCashPayment(
      AddCareCashMappingParams params);

  Future<Either<AppError, ObjectCommonResult>> purchagePlanNewMemberSubmit(
      PuechageNewMemberMappingParams params);
}

class OtherRempoteDataSourceImpl extends OtherRemoteDataSource {
  final ApiClient _client;
  OtherRempoteDataSourceImpl(this._client);

  @override
  Future<Either<AppError, ObjectCommonResult>> addCareCashPayment(
      AddCareCashMappingParams param) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    //user-family-pp-count
    final response = await _client.post(
        'member-carecash', param.toJson(), token);
    print('userSos >>  result response' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    print('result userSos' + result.toString());


    if (result != null&& result.confirmation == 'success') {
      print('result userSosconfirmation' + result.toString());
      return Right(result);
    } else {
      print('resultuserSos AppErrorType' + result.toString());
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> userSos(
      User param) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    //user-family-pp-count
    final response = await _client.post(
        'user-sos', param.toJson(), token);
    print('userSos >>  result response' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    print('result userSos' + result.toString());


    if (result != null&& result.confirmation == 'success') {
      print('result userSosconfirmation' + result.toString());
      return Right(result);
    } else {
      print('resultuserSos AppErrorType' + result.toString());
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> purchagePlanNewMemberSubmit(
      PuechageNewMemberMappingParams param) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    //user-family-pp-count
    final response = await _client.post(
        'mobile-family-members', param.toJson(), token);
    print('purchagePlanNewMemberSubmit >>  result response' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    print('result purchagePlanNewMemberSubmit' + result.toString());


    if (result != null&& result.confirmation == 'success') {
      print('result confirmation' + result.toString());
      return Right(result);
    } else {
      print('result AppErrorType' + result.toString());
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> purchagePlanPayment(
      PuechagePackageMappingParams param) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    //user-family-pp-count
    final response = await _client.post(
        'payment', param.toJson(), token);
    print('getUserFamilyppcount >>  result response' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    print('result getMedicine' + result.toString());
    if (result.confirmation == 'success') {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, PageResult>> getPage(String page_name) async {
    final response =
        await _client.donkeypost('app-read-page', {"page_name": '$page_name'});

    final page = PageResult.fromJson(response);
    if (page.confirmation == 'success') {
      return Right(page);
    } else {
      return Left(AppError(AppErrorType.api, message: page.data));
    }
  }

  @override
  Future<Either<AppError, List<ActivityResult>>> getActivities(
      int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    final response = await _client.get(
        'member-service-mappings?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22schedule_date%22,%22DESC%22],%22dquery%22:{%22family_member%22:%22${member_id}%22}}',
        token);

    print('response getActivities ========>' + response.toString());
    final result = ActivityMainResult.fromJson(response).data;
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<PreviousReport>>> getPreviousReports(
      int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    final response = await _client.get(
        'member-reports?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22family_member_id%22:%22${member_id}%22}}',
        token);

    final result = PreviousReportResult.fromJson(response).data;
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<Invoice>>> getInvoices() async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.get(
        'invoices?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22user%22:${user.id}}}',
        token);
    print('result getInvoices' + response.toString());
    final result = SubscriptionResult.fromJson(response).data;
    print('result getInvoices' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<ActivityResult>>> getReports(
      int member_id) async {
    //member-service-mappings?q={%22limit%22:6,%22page%22:1,%22short%22:[%22schedule_date%22,%22DESC%22],%22dquery%22:{%22family_member%22:%2299%22,%22type%22:[%22Lab%22,%22Radiology%22]}}
    String token = await SharedPreferenceHelper.getTokenPref();

    final response = await _client.get(
        'member-service-mappings?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22schedule_date%22,%22DESC%22],%22dquery%22:{%22family_member%22:%22${member_id}%22,%22type%22:[%22Lab%22,%22Radiology%22]}}',
        token);

    print('response getReports ========>' + response.toString());
    final result = ActivityMainResult.fromJson(response).data;
    if (result != null) {
      final response_detail = await _client.get(
          'member-ocr-data?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22updated_at%22,%22DESC%22],%22dquery%22:{%22patient_id%22:%22${member_id}%22}}',
          token);
      print('result response_detail ===============' +
          response_detail.toString() +
          '=============================');
      final resultDetail = ReportDetail.fromJson(response_detail).data;
      final masterKeyLabels =
          ReportDetail.fromJson(response_detail).masterKeyLabels;
      var mapDetail = {};

      resultDetail.forEach((i) => {
            mapDetail[i.memberServiceMappingId] = i.vitalValue.data != null
                ? List<VitalVal>.from(
                    i.vitalValue.data.map((item) => VitalVal.fromJson({
                          'vital_key': item.vital_key,
                          'vital_value': item.vital_value,
                          'vital_label': getLabel(item.vital_key,
                              i.ocrRaw.reportLab, masterKeyLabels)
                        })))
                : ''
          });

      for (var item in result) {
        item.vitalVals = mapDetail[item.id];
        // }
      }
      ;

      print('mapDetail =========>' + result.toString());
      // print('result report details ======>' + resultDetail.toString());

      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  getLabel(key, reportLab, MasterKeyLabels masterKeyLabels) {
    print(masterKeyLabels.labs);
    String label = '';
    masterKeyLabels.labs.forEach((element) {
      print('element.label' + element.label);
      if (element.label == reportLab) {
        element.list.forEach((elm) {
          if (key == elm.key) {
            label = elm.label;
          }
        });
      }
    });
    return label;
  }

  @override
  Future<Either<AppError, PrescriptionMain>> getPrescriptions(int id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.get('viewdrprescription/${id}', token);

    print('response getPrescriptions ========>' + response.toString());
    final result = PrescriptionMain.fromJson(response);
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<MedicineData>>> getMedicine(
      int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.get(
        'drprescriptionmedicine?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22patientId%22:%22${member_id}%22}}',
        token);

    final result = MedicineModel.fromJson(response).data;
    print('result getMedicine' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }




  @override
  Future<Either<AppError, ImmunizationModel>> getUserFamilyppcount(
      int userId) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    //user-family-pp-count
    final response = await _client.post(
        'user-family-pp-count', {"user_id": '$userId'}, token);
    print('getUserFamilyppcount >>  result response' + response.toString());
    final result = ImmunizationModel.fromPPcountJson(response);
    print('result getMedicine' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }
  @override
  Future<Either<AppError, List<ImmunizationData>>> getImmunization(
      int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.get(
        'immunization?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22patientId%22:%22${member_id}%22}}',
        token);

    final result = ImmunizationModel.fromJson(response).data;
    print('result getMedicine' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<MedicineData>>> getConference(
      int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.post(
        'videoconference', {"patient_id": '$member_id'}, token);
    print('result response' + response.toString());
    final result = MedicineModel.fromJson(response).data;
    print('result getMedicine' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, ReportDetail>> getOcr(int member_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    // User user = await SharedPreferenceHelper.getUserPref();
    final response = await _client.get(
        'member-ocr-data?q={%22limit%22:1000,%22page%22:1,%22short%22:[%22updated_at%22,%22DESC%22],%22dquery%22:{%22patient_id%22:%22${member_id}%22}}',
        token);
    print('result response' + response.toString());
    final result = ReportDetail.fromJson(response);
    print('result report details ======>' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, List<DataMain>>> getOcrSearch(
      int member_id, String search) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    // User user = await SharedPreferenceHelper.getUserPref();
    final response = await _client.get(
        'member-ocr-data-search?q={%22st%22:%22${search}%22,%22short%22:[%22updated_at%22,%22DESC%22],%22dquery%22:{%22patient_id%22:%22${member_id}%22}}',
        token);
    print('result response' + response.toString());
    final result = VitalValMain.fromJson(response).data;
    print('result report details  getOcrSearch ======>' + result.toString());
    if (result != null) {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> uploadReport(
      ServiceUploadParams params) async {
    print('params' + params.toJson().toString());
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.postMultiPartData('document/strapi-upload',
        params.document, token, params.family_member.toString());
    print('result response file =====>' + response.toString());
    if (response != null) {
      print('<===================================================>');
      final responseMain = await _client.post('member-service-mappings',
          {...params.toJson(), 'doc_data': response}, token);
      final result = ObjectCommonResult.fromJson(responseMain);
      print('result report details  uploadReport responseMain======>' +
          result.toString());
      if (result.confirmation == 'success') {
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.api, message: 'Upload Error'));
      }
    } else {
      return Left(AppError(AppErrorType.api, message: 'Upload Error'));
    }
  }

  @override
  Future<Either<AppError, TrendMain>> getTrend(
      int patient_id, String unique_key) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    final response = await _client.post('member-ocr-trend',
        {"patient_id": '$patient_id', 'unique_key': unique_key}, token);
    print('result response' + response.toString());
    final result = TrendMain.fromJson(response);
    print('result getMedicine' + result.toString());
    if (result.confirmation == 'success') {
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, int>> getPaymentFees(int appointment_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.get('appointment-fee', token);
    final result = ArrayCommonResult.fromJson(response);
    if (result.confirmation == 'success') {
      return Right(result.data[0]['fee']);
    } else {
      return Left(AppError(AppErrorType.api, message: 'No data found'));
    }
  }

  @override
  Future<Either<AppError, PResult>> updatePayment(RozorPayMappingParams razorpay_responses) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    int appointment_id = await SharedPreferenceHelper.getAppointmentIdPref();
    int bookService_id = await SharedPreferenceHelper.getBookServiceIdPref();


    if(appointment_id!=null){

      final response = await _client.put('appointment-member-credit/${appointment_id}',   token,
        {
          'razorpay_response': razorpay_responses,

        }

       );

      final result = PResult.fromJson(response);
      if (result != null) {
        print('result updatePayment =>' + result.toString());
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.api, message: 'No data found'));
      }
    }else{
      final response = await _client.put('bookservice-member-credit/${bookService_id}', token, {
        'razorpay_response': razorpay_responses,

      });

      final result = PResult.fromJson(response);
      if (result != null) {
        print('result updatePayment =>' + result.toString());
        return Right(result);
      } else {
        return Left(AppError(AppErrorType.api, message: 'No data found'));
      }
    }
  }

  @override
  Future<Either<AppError, ObjectCommonResult>> cancelAppointment(
      int appointment_id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.put('appointment/${appointment_id}', token, {
      'status': '3',
    });

    final result = ObjectCommonResult.fromJson(response);
    if (result != null) {
      print('result cancelAppointment =>' + result.toString());
      return Right(result);
    } else {
      return Left(AppError(AppErrorType.api, message: 'Error in cancel.'));
    }
  }
}
