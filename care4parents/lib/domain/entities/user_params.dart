import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserParams extends Equatable {
  final String id;
  final String email;
  final String password;
  final String name;
  final String username;
  final String phone_number;
  final String country;
  final String address;

  UserParams({
    this.id,
    this.email,
    this.password,
    this.name,
    this.username,
    this.phone_number,
    this.country,
    this.address,
  });

  @override
  List<Object> get props =>
      [id, email, password, name, username, phone_number, country, address];
}
