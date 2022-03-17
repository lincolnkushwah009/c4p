import 'package:json_annotation/json_annotation.dart';
part 'fb_result.g.dart';

@JsonSerializable()
class FbResult {
  Object picture;
  String name;
  String first_name;
  String last_name;
  String email;
  String id;

  FbResult(
      {this.id,
      this.first_name,
      this.last_name,
      this.name,
      this.email,
      this.picture});

  @override
  String toString() =>
      'FB result { first_name: $first_name, name: $name, email: $email}';
  factory FbResult.fromJson(Map<String, dynamic> json) =>
      _$FbResultFromJson(json);
  Map<String, dynamic> toJson() => _$FbResultToJson(this);
}
