part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupLoadEvent extends SignupEvent {
  final String email;
  final String password;
  final String name;
  final String username;

  const SignupLoadEvent(this.email, this.password, this.name, this.username);

  @override
  List<Object> get props => [email, password];
}

class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class SignupCodeChanged extends SignupEvent {
  const SignupCodeChanged(this.country_code);
  final String country_code;

  @override
  List<Object> get props => [country_code];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignupUserNameChanged extends SignupEvent {
  const SignupUserNameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
