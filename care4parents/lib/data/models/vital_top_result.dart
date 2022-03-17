import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user_package.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vital_top_result.g.dart';

@JsonSerializable()
class VitalTopResult extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final bool showGraph;
  final String name;
  final List<VitalTypeResult> list;

  VitalTopResult({
    this.startDate,
    this.endDate,
    this.showGraph,
    this.list,
    this.name,
  });
  VitalTopResult copyWith({
    DateTime startDate,
    DateTime endDate,
    bool showGraph,
    String name,
    List<VitalTypeResult> list,
  }) =>
      VitalTopResult(
        startDate: startDate ?? this.startDate,
        name: name ?? this.name,
        endDate: endDate ?? this.endDate,
        showGraph: showGraph ?? this.showGraph,
        list: list ?? this.list,
      );

  @override
  String toString() =>
      'VitalTopResult {name: $name startDate: $startDate, endDate: $endDate showGraph: $showGraph}';
  factory VitalTopResult.fromJson(Map<String, dynamic> json) =>
      _$VitalTopResultFromJson(json);
  Map<String, dynamic> toJson() => _$VitalTopResultToJson(this);

  @override
  List<Object> get props => [showGraph, startDate, endDate, list];
}
