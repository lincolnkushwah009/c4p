part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordCurrentPassChanged extends ChangePasswordEvent {
  const ChangePasswordCurrentPassChanged(this.current_pass);
  final String current_pass;

  @override
  List<Object> get props => [current_pass];
}

class ChangePasswordNewPassChanged extends ChangePasswordEvent {
  const ChangePasswordNewPassChanged(this.new_pass);

  final String new_pass;

  @override
  List<Object> get props => [new_pass];
}

class ChangePasswordConfirmPassChanged extends ChangePasswordEvent {
  const ChangePasswordConfirmPassChanged(this.confirm_pass);

  final String confirm_pass;

  @override
  List<Object> get props => [confirm_pass];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}
