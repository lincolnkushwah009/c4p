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
    var d=value?.isNotEmpty == true ? null : NameValidationError.empty;
   // print('value>> ' +value+ " "+d.toString());
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum CountryValidationError { empty }

class Country extends FormzInput<String, CountryValidationError> {
  const Country.pure() : super.pure('');
  const Country.dirty([String value = '']) : super.dirty(value);

  @override
  CountryValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : CountryValidationError.empty;
  }
}

enum AddressValidationError { empty }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : AddressValidationError.empty;
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

enum PhoneNumberValidationError { empty, invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError validator(String value) {
    return value?.isNotEmpty != true
        ? PhoneNumberValidationError.empty
        : (value != null && (value.length < 10 || value.length > 10))
            ? PhoneNumberValidationError.invalid
            : null;
  }
}
