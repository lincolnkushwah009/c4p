part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLoadEvent extends LoginEvent {
  final String email;
  final String password;
  final String username;

  const LoginLoadEvent(this.email, this.password,this.username);

  @override
  List<Object> get props => [email, password];
}
class LoginCodeChanged extends LoginEvent {
  const LoginCodeChanged(this.country_code);
  final String country_code;

  @override
  List<Object> get props => [country_code];
}
class LoginmobileChanged extends LoginEvent {
  const LoginmobileChanged(this.username, this.email, this.password);
  final String email;
  final String username;
  final String password;
  @override
  List<Object> get props => [username,password,email];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class SignInWithGooglePressed extends LoginEvent {
  const SignInWithGooglePressed();
}

class LoginToFacebook extends LoginEvent {
  const LoginToFacebook();
}
class LoginToApple extends LoginEvent {
  const LoginToApple();
}
