import 'package:equatable/equatable.dart';

class SocialLoginParams extends Equatable {
  final String authToken;
  final String email;
  final String firstName;
  final String id;
  final String idToken;
  final String lastName;
  final String name;
  final String photoUrl;
  final String provider;

  SocialLoginParams(
      {this.authToken,
      this.email,
      this.firstName,
      this.lastName,
      this.id,
      this.idToken,
      this.name,
      this.photoUrl,
      this.provider});

  @override
  List<Object> get props => [
        authToken,
        email,
        firstName,
        lastName,
        provider,
        photoUrl,
        name,
        idToken,
        id
      ];
  Map<String, dynamic> toJson() => {
        "authToken": authToken,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "provider": provider,
        "photoUrl": photoUrl,
        "name": name,
        "idToken": idToken,
        "id": id,
      };
}
