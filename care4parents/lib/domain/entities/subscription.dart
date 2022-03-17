import 'package:care4parents/data/models/family_member.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Subscription extends Equatable {
  final int id;
  final String name;
  final String subscription_date;
  final String package;
  final String amount;

  Subscription({
    @required this.id,
    @required this.name,
    @required this.subscription_date,
    @required this.package,
    @required this.amount,
  });

  @override
  List<Object> get props => [id, name, subscription_date, package, amount];
}

class SubscriptionResult {
  List<Invoice> data;
  int total;
  int page;
  int limit;

  SubscriptionResult({this.data, this.total, this.page, this.limit});

  SubscriptionResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Invoice>();
      json['data'].forEach((v) {
        data.add(new Invoice.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class Invoice {
  int id;
  String invoiceNo;
  String date;
  String address;
  String invoiceFile;
  int quantity;
  String taxablevalue;
  String totalIgstAmt;
  String totalCgstAmt;
  String totalSgstAmt;
  String totalDiscount;
  String totalAmount;
  String paymentLink;
  Null comment;
  String status;
  String createdAt;
  String updatedAt;
  int user;
  int familyMember;
  Null createdBy;
  Null updatedBy;
  FamilyMember familyMembers;
  UserId userId;

  Invoice(
      {this.id,
      this.invoiceNo,
      this.date,
      this.address,
      this.invoiceFile,
      this.quantity,
      this.taxablevalue,
      this.totalIgstAmt,
      this.totalCgstAmt,
      this.totalSgstAmt,
      this.totalDiscount,
      this.totalAmount,
      this.paymentLink,
      this.comment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.familyMember,
      this.createdBy,
      this.updatedBy,
      this.familyMembers,
      this.userId});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    date = json['date'];
    address = json['address'];
    invoiceFile = json['invoice_file'];
    quantity = json['quantity'];
    taxablevalue = json['taxablevalue'];
    totalIgstAmt = json['total_igst_amt'];
    totalCgstAmt = json['total_cgst_amt'];
    totalSgstAmt = json['total_sgst_amt'];
    totalDiscount = json['total_discount'];
    totalAmount = json['total_amount'];
    paymentLink = json['payment_link'];
    comment = json['comment'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'];
    familyMember = json['family_member'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    familyMembers = json['family_members'] != null
        ? new FamilyMember.fromJson(json['family_members'])
        : null;
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['date'] = this.date;
    data['address'] = this.address;
    data['invoice_file'] = this.invoiceFile;
    data['quantity'] = this.quantity;
    data['taxablevalue'] = this.taxablevalue;
    data['total_igst_amt'] = this.totalIgstAmt;
    data['total_cgst_amt'] = this.totalCgstAmt;
    data['total_sgst_amt'] = this.totalSgstAmt;
    data['total_discount'] = this.totalDiscount;
    data['total_amount'] = this.totalAmount;
    data['payment_link'] = this.paymentLink;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    data['family_member'] = this.familyMember;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.familyMembers != null) {
      data['family_members'] = this.familyMembers.toJson();
    }
    if (this.userId != null) {
      data['userId'] = this.userId.toJson();
    }
    return data;
  }
}

class UserId {
  int id;
  String username;
  String email;
  String provider;
  String password;
  String resetPasswordToken;
  bool confirmed;
  bool blocked;
  String name;
  String phoneNumber;
  String profilephoto;
  String country;
  // Null user;
  String address;
  String credits;
  String createdAt;
  String updatedAt;
  // Null createdBy;
  // Null updatedBy;
  int role;

  UserId(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.password,
      this.resetPasswordToken,
      this.confirmed,
      this.blocked,
      this.name,
      this.phoneNumber,
      this.profilephoto,
      this.country,
      // this.user,
      this.address,
      this.credits,
      this.createdAt,
      this.updatedAt,
      // this.createdBy,
      // this.updatedBy,
      this.role});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    password = json['password'];
    resetPasswordToken = json['resetPasswordToken'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    profilephoto = json['profilephoto'];
    country = json['country'];
    // user = json['user'];
    address = json['address'];
    credits = json['credits'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // createdBy = json['created_by'];
    // updatedBy = json['updated_by'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['password'] = this.password;
    data['resetPasswordToken'] = this.resetPasswordToken;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['profilephoto'] = this.profilephoto;
    data['country'] = this.country;
    // data['user'] = this.user;
    data['address'] = this.address;
    data['credits'] = this.credits;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['created_by'] = this.createdBy;
    // data['updated_by'] = this.updatedBy;
    data['role'] = this.role;
    return data;
  }
}
