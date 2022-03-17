import 'package:care4parents/domain/entities/appointment_entity.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel extends ServiceEntity {
  final int id;
  final String service;
  final String remarks;
  final String bookingdate;
  final String startbookingdate;
  final String endbookingdate;
  final String specialist_type;
  final String timerange;

  ServiceModel(
      {this.id,
      this.service,
      this.remarks,
      this.bookingdate,
      this.startbookingdate,
      this.specialist_type,
      this.timerange,
      this.endbookingdate});

  @override
  String toString() =>
      'Service Model String Json { id: $id, service: $service, bookingdate: $bookingdate, timerange $timerange}';
  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
