import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError validator(String value) {
    return value?.isNotEmpty != true
        ? EmailValidationError.empty
        : (!value.contains("@") || !value.contains("."))
            ? EmailValidationError.invalid
            : null;
  }
}

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum UserNameValidationError { empty }

class UserName extends FormzInput<String, UserNameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : UserNameValidationError.empty;
  }
}
