import 'package:care4parents/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_result.g.dart';

@JsonSerializable()
class UserResult {
  User user;
  String confirmation;
  String message;
  String jwt;

  UserResult({this.user, this.confirmation, this.message, this.jwt});

  @override
  String toString() =>
      'User result { user: $user, confirmation: $confirmation, jwt: $jwt, message: $message}';
  factory UserResult.fromJson(Map<String, dynamic> json) =>
      _$UserResultFromJson(json);
  Map<String, dynamic> toJson() => _$UserResultToJson(this);
}
