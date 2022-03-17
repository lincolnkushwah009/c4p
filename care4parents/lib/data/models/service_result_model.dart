import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_result_model.g.dart';

@JsonSerializable()
class ServiceResultModel {
  List<Service> data;
  int total;
  int page;
  int limit;
  ServiceResultModel({this.data, this.limit, this.page, this.total});

  @override
  String toString() =>
      'Object Common result { data: $data, limit: $limit, page: $page}';
  factory ServiceResultModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResultModelToJson(this);
}
