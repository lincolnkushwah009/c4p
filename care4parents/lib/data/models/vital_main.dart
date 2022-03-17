import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user_package.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vital_main.g.dart';

@JsonSerializable()
class VitalMain extends Equatable {
  final String confirmation;
  final List<VitalTypeResult> data;

  VitalMain({this.confirmation, this.data});

  @override
  String toString() => 'VitalMain { confirmation: $confirmation, data: $data}';
  factory VitalMain.fromJson(Map<String, dynamic> json) =>
      _$VitalMainFromJson(json);
  Map<String, dynamic> toJson() => _$VitalMainToJson(this);

  @override
  List<Object> get props => [confirmation, data];
}
