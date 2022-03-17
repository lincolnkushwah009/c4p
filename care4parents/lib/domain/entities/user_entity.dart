import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String password;
  final String username;
  final String name;
  final String profilephoto;
  final String phone_number;
  final String country;
  final String address;
  final String message;
  final bool confirmed;

  UserEntity(
      {@required this.id,
      @required this.email,
      @required this.password,
      @required this.username,
      @required this.name,
      this.profilephoto,
      this.country,
      this.phone_number,
      this.address,
      this.message,this.confirmed});

  @override
  List<Object> get props => [
        id,
        email,
        password,
        username,
        name,
        profilephoto,
        country,
        phone_number,
        address,
        message,confirmed
      ];
}
