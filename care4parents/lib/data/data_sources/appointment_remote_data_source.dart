import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/service_model.dart';
import 'package:care4parents/data/models/service_result_model.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAppointments(int tab);
  Future<List<Service>> getServcies(int tab);
  Future<ObjectCommonResult> createAppointment(AppointmentParams params);
  Future<ObjectCommonResult> createService(ServiceParams params);
}

class AppointmentRempoteDataSourceImpl extends AppointmentRemoteDataSource {
  final ApiClient _client;
  AppointmentRempoteDataSourceImpl(this._client);

  @override
  Future<List<AppointmentModel>> getAppointments(int tab) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();
    var dt = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd H:m");
    String date = newFormat.format(dt);
    print('date >>>>>>>>>>>' + date);
    final response = await _client.post(
        'listappointment',
        {
          'limit': 25,
          'page': 1,
          'short': ['created_at', 'DESC'],
          'user_id': user.id,
          'tab': tab,
          'tdate': date,
          'searchKey': '',
        },
        token);
    print('response getAppointments =======' + response.toString());
    final appointments = AppiontmentResultModel.fromJson(response).data;
    print('appointments ===============' + appointments.toString());
    return appointments;
  }

  @override
  Future<ObjectCommonResult> createAppointment(AppointmentParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();
    final response = await _client.post(
        'mobile/appointment', {...params.toJson(), 'user_id': user.id}, token);
    print('response createAppointment =======' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    if (result.confirmation == 'success') {
      return result;
    }
    return null;
  }

  @override
  Future<ObjectCommonResult> createService(ServiceParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();
    final response = await _client.post(
        'mobile/bookservice', {...params.toJson(), 'user_id': user.id}, token);
    print('response createService =======' + response.toString());
    final result = ObjectCommonResult.fromJson(response);
    if (result.confirmation == 'success') {
      return result;
    }
    return null;
  }

  @override
  Future<List<Service>> getServcies(int tab) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();
    var dt = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd H:m");
    String date = newFormat.format(dt);
    print('date >>>>>>>>>>>' + date);
    final response = await _client.post(
        'listbookservice',
        {
          'limit': 25,
          'page': 1,
          'short': ['created_at', 'DESC'],
          'user_id': user.id,
          'tab': tab,
          'tdate': date,
          'searchKey': '',
        },
        token);
    print('response getServcies =======' + response.toString());
    final services = ServiceResultModel.fromJson(response).data;
    print('services ===============' + services.toString());
    return services;
  }
}
