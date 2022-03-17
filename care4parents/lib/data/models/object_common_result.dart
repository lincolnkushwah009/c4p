import 'package:json_annotation/json_annotation.dart';
part 'object_common_result.g.dart';

@JsonSerializable()
class ObjectCommonResult {
  Object data;
  String confirmation;
  String message;

  ObjectCommonResult({this.data, this.confirmation, this.message});

  @override
  String toString() =>
      'Object Common result { data: $data, confirmation: $confirmation, message: $message}';
  factory ObjectCommonResult.fromJson(Map<String, dynamic> json) =>
      _$ObjectCommonResultFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectCommonResultToJson(this);
}

class PResult {
  int id;

  PResult({
    this.id,
  });

  PResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }
}
