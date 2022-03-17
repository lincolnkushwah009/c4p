import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_add.g.dart';

@JsonSerializable()
class SubscriptionAdd extends Equatable {
  final int currentStep;
  final String fullName;
  final String gender;
  final String relation;
  final String dateOfBirth;
  final String email;
  final String address;
  final String phone;
  final String contactPerson;
  final String contactNo;
  final String package_name;
  final String package_code;
  final String package_duration;
  final int package_id;
  final int package_price;
  final String pincode;
  final String state;
  final int discountAmount;
  final int promocode_id;
  final String promocode_name;

  SubscriptionAdd(
      {this.fullName,
      this.gender,
      this.currentStep,
      this.relation,
      this.dateOfBirth,
      this.email,
      this.address,
      this.phone,
      this.contactPerson,
      this.contactNo,
      this.package_id,
      this.package_price,
      this.package_name,
      this.package_code,
      this.package_duration,
      this.pincode,
      this.state,
      this.discountAmount,
      this.promocode_id,
      this.promocode_name})
      : super();

  factory SubscriptionAdd.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionAddFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionAddToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
