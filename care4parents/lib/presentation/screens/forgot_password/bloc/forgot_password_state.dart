part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
  });
  final FormzStatus status;
  final Email email;

  ForgotPasswordState copyWith({
    FormzStatus status,
    Email email,
    Password password,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [status, email];
}
