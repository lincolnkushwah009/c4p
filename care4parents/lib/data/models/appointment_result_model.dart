// import 'package:care4parents/data/models/appointment_model.dart';

// class AppiontmentResultModel {
//   List<AppointmentModel> data;
//   int total;
//   int page;
//   int limit;
//   AppiontmentResultModel({this.data, this.limit, this.page,});

//   AppiontmentResultModel.fromJson(Map<String, dynamic> json) {
//     // if (json['confirmation'] == 'failed') {
//     //   data = new List<AppointmentModel>();
//     //   // data.add(AppointmentModel.fromJson({
//     //   //   'id': 1,
//     //   //   'specialist': 'Dr, Julie',
//     //   //   'specialist_type': 'Psychiatrist',
//     //   //   'appointment_date': '2021-03-02 09:08:00'
//     //   // }));
//     //   // appointments.add(AppointmentModel.fromJson({
//     //   //   'id': 2,
//     //   //   'specialist': 'Dr, Julie',
//     //   //   'specialist_type': 'Psychiatrist',
//     //   //   'appointment_date': '2021-03-02 09:08:00'
//     //   // }));
//     // }
//     // if (json['results'] != null) {
//     //   appointments = new List<AppointmentModel>();
//     //   json['results'].forEach((v) {
//     //     appointments.add(AppointmentModel.fromJson(v));
//     //   });
//     // }
//   }
// }

import 'package:care4parents/data/models/appointment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_result_model.g.dart';

@JsonSerializable()
class AppiontmentResultModel {
  List<AppointmentModel> data;
  int total;
  int page;
  int limit;
  AppiontmentResultModel({this.data, this.limit, this.page, this.total});

  @override
  String toString() =>
      'Object Common result { data: $data, limit: $limit, page: $page}';
  factory AppiontmentResultModel.fromJson(Map<String, dynamic> json) =>
      _$AppiontmentResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppiontmentResultModelToJson(this);
}
