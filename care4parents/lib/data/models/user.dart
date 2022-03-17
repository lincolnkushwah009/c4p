import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends UserEntity {
  final int id;
  final String email;
  final String password;
  final String username;
  final String provider;
  final String resetPasswordToken;
  final String name;
  final String phone_number;
  final String country;
  final String address;
  final String credits;
  final String profilephoto;
  final int role;
  final bool confirmed;
  String message;
  User(
      {this.id,
      this.email,
      this.password,
      this.username,
      this.provider,
      this.resetPasswordToken,
      this.name,
      this.phone_number,
      this.address,
      this.country,
      this.credits,
      this.profilephoto,
      this.message,
      this.role,this.confirmed});

  @override
  String toString() =>
      'User { email: $email, username: $username, profilephoto: $profilephoto , message : $message}';
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
