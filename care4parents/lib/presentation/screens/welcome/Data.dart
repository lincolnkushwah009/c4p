import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Data {
  int
      is_pan_verified,
      is_acc_verified,
      is_email_verified,
      totalWinContest,
      totalJoinContest,version,version_code,show_updateios,iosversion,force_update,iosForceupdate,app_type,bonus_offers,isShowAppUpdate;

  String userId, referance_code, id,apklink,message,headermsg,updatemsg,OTP;
  String first_name, pan_number;
  String email;
  String phone,value,
      ifsc,
      branch_name,
      bank_name,
      account_proof,
      account_number,
      walletId,
      holder_name,
      token,
      profile_img,
      pan_holder_name,
      address,
      city,
      dob,
      gender,
      last_name,
      state,
      team_name,
      zipcode,
      bank_description,
      pan_description,
      pan_image,
      partnerCode;

  Data(
      {this.OTP,
      this.id,this.value,this.message,this.bonus_offers,this.headermsg,this.isShowAppUpdate,this.updatemsg,this.iosForceupdate,
      this.partnerCode,
      this.totalWinContest,
      this.referance_code,
      this.totalJoinContest,
      this.token,
      this.bank_description,
      this.pan_description,
      this.profile_img,
      this.pan_number,
      this.pan_image,
      this.account_proof,
      this.pan_holder_name,this.show_updateios,
      this.bank_name,
      this.is_pan_verified,
      this.is_acc_verified,
      this.is_email_verified,
      this.walletId,
      this.account_number,
      this.userId,
      this.branch_name,
      this.first_name,
      this.holder_name,
      this.phone,
      this.ifsc,
      this.zipcode,
      this.address,
      this.city,
      this.dob,
      this.gender,
      this.last_name,
      this.state,
      this.team_name,this.version,this.version_code,this.force_update,this.app_type,this.apklink,this.iosversion,
      this.email});
//  "version": 1,
//  "version_code": 0,
//  "app_type": 0,
//  "force_update": 0,

  factory Data.fromVersionJson(Map<String, dynamic> json) {
    return Data(
        version: json['version'],
        version_code: json['version_code'],
        force_update: json['force_update'],
        app_type: json['app_type'],
        apklink:json['apklink']
      );
  }
  factory Data.fromfcmVersionJson(json) {
    return Data(
        version: json['version'],
        version_code: json['version_code'],
        force_update: json['force_update'],
        iosForceupdate: json['iosForceupdate'],
        show_updateios: json['show_updateios'],
        iosversion: json['iosversion'],

        app_type: json['app_type'],
        apklink:json['apklink'],
        bonus_offers:json['bonus_offers'],
        headermsg:json['headermsg'],
        updatemsg:json['updatemsg'],
        isShowAppUpdate:json['isShowAppUpdate'],
         message:json['message']
    );
  }

  factory Data.fromddJson(Map<String, dynamic> json) {
    return Data(
        referance_code: json['referance_code'],
        totalWinContest: json['totalWinContest'],
        totalJoinContest: json['totalJoinContest'],
        city: json['city'],
        address: json['address'],
        dob: json['dob'],
        gender: json['gender'],
        last_name: json['last_name'],
        state: json['state'],
        team_name: json['team_name'],
        zipcode: json['zipcode'],
        email: json['email'],
        partnerCode: json['partner_code'],
        phone: json['phone'],
        first_name: json['first_name'],
        walletId: json['walletId'],
        profile_img: json['profile_img'],
        userId: json['userId']);
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        referance_code: json['referance_code'],
        partnerCode: json['partner_code'],
        OTP: json['OTP'].toString(),
        email: json['email'],
        phone: json['phone'],
        first_name: json['first_name'],
        walletId: json['walletId'],
        team_name: json['team_name'],
        token: json['token'],
        userId: json['userId']);
  }




  factory Data.fromSaveteamJson(Map<String, dynamic> json) {
    return Data(id: json['_id'], team_name: json['team_name']);
  }

  factory Data.fromjoinJson(Map<String, dynamic> json) {
    return Data(
      partnerCode: json['partner_code'],
    );
  }
  factory Data.fromjoinPartvalue(Map<String, dynamic> json) {
    return Data(
      value: json['value'],
    );
  }

  factory Data.fromkycJson(Map<String, dynamic> json) {
    return Data(
        account_number: json['account_number'],
        account_proof: json['account_proof'],
        branch_name: json['branch_name'],
        bank_name: json['bank_name'],
        ifsc: json['ifsc'],
        holder_name: json['holder_name'],
        email: json['email'],
        phone: json['phone'],
        pan_image: json['pan_image'],
        pan_number: json['pan_number'],
        pan_holder_name: json['pan_holder_name'],
        first_name: json['first_name'],
        is_pan_verified: json['is_pan_verified'],
        is_acc_verified: json['is_acc_verified'],
        is_email_verified: json['is_email_verified'],
        walletId: json['walletId'],
        bank_description: json['bank_description'],
        pan_description: json['pan_description'],
        userId: json['userId']);
  }
  factory Data.fromWalletJson(Map<String, dynamic> json) {
    return Data(
      is_pan_verified: json['is_pan_verified'],
      is_acc_verified: json['is_acc_verified'],
      is_email_verified: json['is_email_verified'],
    );
  }

  Map<String, dynamic> toJson() => {
        'OTP': OTP,
      };
//  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
//  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
