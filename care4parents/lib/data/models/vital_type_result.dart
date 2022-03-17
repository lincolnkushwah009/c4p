import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user_package.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vital_type_result.g.dart';

@JsonSerializable()
class VitalTypeResult extends Equatable {
  final int id;
  final String device;
  final String ecgfiles;
  final DateTime measureOn;
  final String type;
  final String value;
  final String systolic;
  final String diastolic;

  VitalTypeResult(
      {this.id,
      this.device,
      this.ecgfiles,
      this.measureOn,
      this.type,
      this.value,
      this.systolic,
      this.diastolic});

  @override
  String toString() => 'VitalTypeResult { ecgfiles: $ecgfiles}';
  factory VitalTypeResult.fromJson(Map<String, dynamic> json) =>
      _$VitalTypeResultFromJson(json);
  Map<String, dynamic> toJson() => _$VitalTypeResultToJson(this);

  @override
  List<Object> get props => [id, device, ecgfiles, measureOn, type, value];
}
