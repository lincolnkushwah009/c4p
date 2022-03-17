import 'package:care4parents/domain/entities/package.dart';
import 'package:json_annotation/json_annotation.dart';
part 'package_result_model.g.dart';

@JsonSerializable()
class PackageResultModel {
  List<Package> data;

  PackageResultModel({this.data});

  @override
  String toString() => 'Package result { data: $data}';
  factory PackageResultModel.fromJson(Map<String, dynamic> json) =>
      _$PackageResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackageResultModelToJson(this);
}
