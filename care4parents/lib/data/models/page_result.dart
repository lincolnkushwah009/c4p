import 'package:json_annotation/json_annotation.dart';
part 'page_result.g.dart';

@JsonSerializable()
class PageResult {
  String data;
  String confirmation;

  PageResult({this.data, this.confirmation});

  @override
  String toString() =>
      'Page result { data: $data, confirmation: $confirmation}';
  factory PageResult.fromJson(Map<String, dynamic> json) =>
      _$PageResultFromJson(json);
  Map<String, dynamic> toJson() => _$PageResultToJson(this);
}


class PaymentRes {
  int id;

  PaymentRes({this.id});

  PaymentRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}