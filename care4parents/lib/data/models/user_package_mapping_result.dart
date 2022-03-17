import 'package:json_annotation/json_annotation.dart';

part 'user_package_mapping_result.g.dart';

@JsonSerializable()
class UserPackageMappingResult {
  int id;
  String start_date;
  String end_time;
  String package;
  int order;
  int family_member;
  bool status;

  UserPackageMappingResult({
    this.id,
    this.start_date,
    this.end_time,
    this.package,
    this.order,
    this.status,
    this.family_member,
  });

  @override
  String toString() =>
      'UserPackageMappingResult >>>>> {id: $id package: $package, family_member: $family_member, order: $order}';
  factory UserPackageMappingResult.fromJson(Map<String, dynamic> json) =>
      _$UserPackageMappingResultFromJson(json);
  Map<String, dynamic> toJson() => _$UserPackageMappingResultToJson(this);
}

// {
//     "id": 125,
//     "start_date": "2021-03-22T00:00:00.000Z",
//     "end_time": "2021-04-24T00:00:00.000Z",
//     "package": "5",
//     "order": 165,
//     "status": true,
//     "updatedAt": "2021-03-23T06:37:35.569Z",
//     "createdAt": "2021-03-23T06:37:35.569Z",
//     "family_member": null,
//     "created_by": null,
//     "updated_by": null
// }
