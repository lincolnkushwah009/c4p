part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
        this.username = const UserName.pure(),
        this.country_code = const NotEmptyField.pure(),
      this.error});

  final FormzStatus status;
  final Email email;
  final Password password;
  final UserName username;
  final String error;
  final NotEmptyField country_code;

  LoginState copyWith({
    FormzStatus status,
    Email email,
    String error,
    Password password,
    UserName username,
    NotEmptyField country_code,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      error: error ?? this.error,
      password: password ?? this.password,
      country_code: country_code ?? this.country_code,
      username: username ?? this.username,

    );
  }

  @override
  List<Object> get props => [status, email, password,username, country_code];
}
