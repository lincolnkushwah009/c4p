import 'package:json_annotation/json_annotation.dart';

part 'order_result.g.dart';

@JsonSerializable()
class OrderResult {
  int id;
  String package;
  int family_member;
  int quantity;
  int user;
  String name;
  String order_datetime;
  String phone;
  String state;
  String status;
  String address;
  String pincode;
  int amount;
  String promocode_name;
  int discount_amount;
  int promocode_id;

  OrderResult(
      {this.id,
      this.package,
      this.family_member,
      this.quantity,
      this.user,
      this.name,
      this.order_datetime,
      this.phone,
      this.state,
      this.status,
      this.address,
      this.pincode,
      this.amount,
      this.promocode_id,
      this.promocode_name,
      this.discount_amount});

  @override
  String toString() =>
      'Order result { id: $id, package: $package, family_member: $family_member, user: $user}';
  factory OrderResult.fromJson(Map<String, dynamic> json) =>
      _$OrderResultFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResultToJson(this);
}

// {
//     "confirmation": "success",
//     "data": {
//         "id": 165,
//         "pincode": "457001",
//         "package": "5",
//         "quantity": 1,
//         "name": "demo",
//         "user": 209,
//         "order_datetime": "2021-03-22T00:00:00.000Z",
//         "phone": "8103226822",
//         "state": "mp",
//         "status": "PENDING",
//         "address": "demo address",
//         "family_member": 176,
//         "amount": 0,
//         "updatedAt": "2021-03-23T05:45:47.861Z",
//         "createdAt": "2021-03-23T05:45:47.861Z",
//         "promocode_name": null,
//         "discount_amount": null,
//         "promocode_id": null,
//         "created_by": null,
//         "updated_by": null
//     }
// }
