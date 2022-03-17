part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzStatus.pure,
    this.current_pass = const NotEmptyField.pure(),
    this.new_pass = const NotEmptyField.pure(),
    this.confirm_pass = const NotEmptyField.pure(),
  });
  final FormzStatus status;
  final NotEmptyField current_pass;
  final NotEmptyField new_pass;
  final NotEmptyField confirm_pass;
  ChangePasswordState copyWith({
    FormzStatus status,
    NotEmptyField current_pass,
    NotEmptyField new_pass,
    NotEmptyField confirm_pass,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      current_pass: current_pass ?? this.current_pass,
      new_pass: new_pass ?? this.new_pass,
      confirm_pass: confirm_pass ?? this.confirm_pass,
    );
  }

  @override
  List<Object> get props => [status, current_pass, new_pass, confirm_pass];
}

class ChangePasswordInitial extends ChangePasswordState {}
