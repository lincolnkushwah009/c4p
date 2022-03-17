// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    email: json['email'] as String,
    password: json['password'] as String,
    username: json['username'] as String,
    provider: json['provider'] as String,
    resetPasswordToken: json['resetPasswordToken'] as String,
    name: json['name'] as String,
    phone_number: json['phone_number'] as String,
    address: json['address'] as String,
    country: json['country'] as String,
    credits: json['credits'] as String,
    profilephoto: json['profilephoto'] as String,
    message: json['message'] as String,
    role: json['role'] as int,
    confirmed: json['confirmed'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'provider': instance.provider,
      'resetPasswordToken': instance.resetPasswordToken,
      'name': instance.name,
      'phone_number': instance.phone_number,
      'country': instance.country,
      'address': instance.address,
      'credits': instance.credits,
      'profilephoto': instance.profilephoto,
      'role': instance.role,
      'message': instance.message,
  'confirmed': instance.confirmed,
    };
