part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const UserName.pure(),
    this.name = const Name.pure(),
    this.error,
    this.country_code = const NotEmptyField.pure(),
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final String error;
  final UserName username;
  final Name name;
  final NotEmptyField country_code;

  SignupState copyWith(
      {FormzStatus status,
      Email email,
      Password password,
      UserName username,
      String error,
      NotEmptyField country_code,
      Name name}) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      error: error ?? this.error,
      country_code: country_code ?? this.country_code,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props =>
      [status, email, password, username, name, country_code];
}
