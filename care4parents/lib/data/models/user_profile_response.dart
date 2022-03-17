import 'package:care4parents/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  String confirmation;
  String originalimage;
  String docurl;

  UserProfileResponse({this.docurl, this.confirmation, this.originalimage});

  @override
  String toString() =>
      'User Profile Response { confirmation: $confirmation, docurl: $docurl}';
  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
