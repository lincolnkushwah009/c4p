import 'package:formz/formz.dart';

enum ValidationError { empty, invalid }

class NotEmptyField extends FormzInput<String, ValidationError> {
  const NotEmptyField.pure() : super.pure('');
  const NotEmptyField.dirty([String value = '']) : super.dirty(value);

  @override
  ValidationError validator(String value) {
    return value?.isNotEmpty != true ? ValidationError.empty : null;
  }
}

class PhoneNumber extends FormzInput<String, ValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  ValidationError validator(String value) {
    return value?.isNotEmpty != true ? ValidationError.empty : null;
    // return value?.isNotEmpty == true
    //     ? null
    //     // : value.length < 10
    //     //     ? ValidationError.invalid
    //     : ValidationError.empty;
  }
}
