import 'package:care4parents/data/core/api_client.dart';
import 'package:care4parents/data/models/appointment_model.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/array_common_result.dart';
import 'package:care4parents/data/models/coupon_code_result.dart';
import 'package:care4parents/data/models/member_main_result.dart';
import 'package:care4parents/data/models/member_result.dart';
import 'package:care4parents/data/models/member_service_mapping_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/order_main_result.dart';
import 'package:care4parents/data/models/order_result.dart';
import 'package:care4parents/data/models/package_result_model.dart';
import 'package:care4parents/data/models/rozar_pay_result.dart';
import 'package:care4parents/data/models/update_family_member_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_family_main_result.dart';
import 'package:care4parents/data/models/user_package_mapping_result.dart';
import 'package:care4parents/data/models/vital_main.dart';
import 'package:care4parents/data/models/vital_top_result.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'dart:math';

import 'package:care4parents/util/config.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<Package>> getPackages();
  Future<MemberResultModel> createMember(MemberParams memberParams);
  Future<ObjectCommonResult> createFamilyMapping(
      MemberMappingParams memberParams);
  Future<OrderResult> createOrder(OrderParams params);
  Future<UserPackageMappingResult> createUserPackageMapping(
      UserPackageMappingParams params);
  Future<ObjectCommonResult> updateFamilyMember(UpdateMemberParams params);
  Future<ArrayCommonResult> memberServiceMapping(
      CreateServiceMappingParams params);
  Future<CouponCodeResult> codeVerification(CouponCodeParams params);
  Future<CouponCodeResult> codeVerification1(CouponCodeParams1 params);
  Future<ObjectCommonResult> updateOrders(int id);
  Future<UserFamilyMainResult> getUserFamilyMapping(FamilyQueryParams params);
  Future<RozarPayResult> createRozarPayOrder(int amount);
  Future<List<VitalTypeResult>> getVitalType(TypeParams params);
  Future<List<List<VitalTypeResult>>> getVitalTypes(TypeParams params);
}

class SubscriptionRemoteDataSourceImpl extends SubscriptionRemoteDataSource {
  final ApiClient _client;
  SubscriptionRemoteDataSourceImpl(this._client);
  final GET_PACKAGE_URL = 'packages';
  final POST_MEMBER_URL = 'family-members';
  final FAMILY_MAPPING = 'user-family-mappings';
  final POST_ORDERS = 'orders';
  final PUT_ORDERS = 'orders';
  final POST_USER_PACKAGE_MAPPING = 'user-package-mappings';
  final PUT_MEMBER_URL = 'family-members';
  final MEMBER_SERVICE_MAPPING_URL = 'member-service-mappings/dynamic';
  final POST_COUPON_CODE = 'promocodes/validate';
  final VITAL_TYPE = 'member-measures/type';

  @override
  Future<List<Package>> getPackages() async {
    String token = await SharedPreferenceHelper.getTokenPref();
    print('response ============ $GET_PACKAGE_URL');
    final response = await _client.get(GET_PACKAGE_URL, token, params: {
      'q':
          '%7B%22limit%22:100,%22page%22:1,%22short%22:%5B%22index%22,%22ASC%22%5D,%22dquery%22:%7B%7D%7D'
    });
    print('response ============ $GET_PACKAGE_URL' + response.toString());
    print('response ============ $token' + token.toString());
    final packages = PackageResultModel.fromJson(response).data;
    return packages;
  }

  @override
  Future<MemberResultModel> createMember(MemberParams memberParams) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.post(
        POST_MEMBER_URL, {...memberParams.toJson(), "user_id": user.id}, token);
    print('response ============ $POST_MEMBER_URL ' + response.toString());
    if (MemberMainResult.fromJson(response).confirmation == 'success') {
      final member = MemberMainResult.fromJson(response).data;
      return member;
    } else {
      return null;
    }
  }

  @override
  Future<ObjectCommonResult> createFamilyMapping(
      MemberMappingParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();
    print('createFamilyMapping params >>>>' + params.toJson().toString());
    final response = await _client.post(
        FAMILY_MAPPING, {...params.toJson(), "user_id": user.id}, token);
    print('response ============ $FAMILY_MAPPING' + response.toString());
    if (ObjectCommonResult.fromJson(response).confirmation == 'success') {
      final result = ObjectCommonResult.fromJson(response);
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<OrderResult> createOrder(OrderParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.post(
        POST_ORDERS, {...params.toJson(), "user": user.id}, token);
    print('response ============ $POST_ORDERS' + response.toString());
    if (OrderMainResult.fromJson(response).confirmation == 'success') {
      final result = OrderMainResult.fromJson(response).data;
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<UserPackageMappingResult> createUserPackageMapping(
      UserPackageMappingParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();

    final response = await _client.post(
        POST_USER_PACKAGE_MAPPING, {...params.toJson()}, token);
    print('response ============ $POST_USER_PACKAGE_MAPPING' +
        response.toString());
    if (UserPackageMappingResult.fromJson(response) != null) {
      final result = UserPackageMappingResult.fromJson(response);
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<ObjectCommonResult> updateFamilyMember(
      UpdateMemberParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    print({...params.toJson()});
    final response = await _client.put(
      PUT_MEMBER_URL,
      token,
      {...params.toJson()},
      {'family_member_id': params.family_member_id.toString()},
    );
    print('response ============ $PUT_MEMBER_URL ============' +
        response.toString());
    if (ObjectCommonResult.fromJson(response).confirmation == 'success') {
      final result = ObjectCommonResult.fromJson(response);
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<ArrayCommonResult> memberServiceMapping(
      CreateServiceMappingParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    User user = await SharedPreferenceHelper.getUserPref();

    final response = await _client.post(
      MEMBER_SERVICE_MAPPING_URL,
      {
        ...params.toJson(),
        'kid_name': user.name,
        'kid_phone': user.phone_number,
      },
      token,
    );
    print('response ============ $MEMBER_SERVICE_MAPPING_URL ============' +
        response.toString());
    if (ArrayCommonResult.fromJson(response).confirmation == 'success') {
      final result = ArrayCommonResult.fromJson(response);
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<CouponCodeResult> codeVerification(CouponCodeParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.post(
      POST_COUPON_CODE,
      {
        ...params.toJson(),
      },
      token,
    );
    print(
        'response ============ MEMBER_SERVICE_MAPPING_URL = $MEMBER_SERVICE_MAPPING_URL ============' +
            response.toString());
    final result = CouponCodeResult.fromJson(response);
    return result;
  }

  @override
  Future<CouponCodeResult> codeVerification1(CouponCodeParams1 params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.post(
      POST_COUPON_CODE,
      {
        ...params.toJson(),
      },
      token,
    );
    print(
        'response ============ codeVerification1 = $POST_COUPON_CODE ============' +
            response.toString());
    final result = CouponCodeResult.fromJson(response);
    return result;
  }

  @override
  Future<ObjectCommonResult> updateOrders(int id) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    print({"id": id});
    final response = await _client.put(PUT_ORDERS, token, {
      "status": 'COMPLETED',
    }, {
      'id': id.toString()
    });
    print(
        'response ============ $PUT_ORDERS ============' + response.toString());
    if (ObjectCommonResult.fromJson(response).confirmation == 'success') {
      final result = ObjectCommonResult.fromJson(response);
      return result;
    } else {
      return null;
    }
  }

  // {{base_url}}user-family-mappings?q={"limit": 25,"page": 1,"short": ["created_at", "ASC"],"dquery": {"user_id":215}}

  @override
  Future<UserFamilyMainResult> getUserFamilyMapping(
      FamilyQueryParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    print(params.dquery.user_id);
    // print(params.dquery.user_id);
    print(token);
    final response = await _client.get(
      'user-family-mappings?q={"limit":${params.limit},"page":${params.page},"short":["created_at", "DESC"],"dquery":{"user_id":${params.dquery.user_id}}}',
      token,
    );

    //print('response ============ $FAMILY_MAPPING' + response.toString());
    if (UserFamilyMainResult.fromJson(response) != null &&
        UserFamilyMainResult.fromJson(response).data.length > 0) {
      // final usersLis =
      //     UserFamilyMainResult.fromJson(response).data[0]?.packageData[0]?.name;
      // print('packageData ========>>==== $FAMILY_MAPPING' + usersLis.toString());
      final usersList = UserFamilyMainResult.fromJson(response);
      return usersList;
    } else {
      return null;
    }
  }

  @override
  Future<RozarPayResult> createRozarPayOrder(int amount) async {
    var username = CONFIG.ROZAR_PAY_KEY;
    var password = CONFIG.ROZAR_PAY_SE;
    var rng = new Random();
    final response = await _client.rozarOrder(
        'https://api.razorpay.com/v1/orders',
        {
          'amount': (amount * 100).toString(), //FIXME: amount
          'currency': 'INR',
          'receipt': 'order_recipt_${rng.nextInt(100)}'
        },
        username,
        password);

    print('response ============ createRozarPayOrder ' + response.toString());
    final result = RozarPayResult.fromJson(response);
    return result;
  }

  @override
  Future<List<VitalTypeResult>> getVitalType(TypeParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    final response = await _client.post(
      VITAL_TYPE,
      {
        ...params.toJson(),
      },
      token,
    );
    print(
        'response ============ getVitalType = member-measures/type ============' +
            response.toString());
    final result = VitalMain.fromJson(response).data;
    return result;
  }

  @override
  Future<List<List<VitalTypeResult>>> getVitalTypes(TypeParams params) async {
    String token = await SharedPreferenceHelper.getTokenPref();
    List<String> itemsIds = ['bp', 'sugar', 'spo2', 'ecg']; //different ids

    List<dynamic> response =
        await Future.wait(itemsIds.map((itemId) => _client.post(
              VITAL_TYPE,
              {...params.toJson(), 'type': itemId},
              token,
            )));
    // print('response ++++++++++++++++' + response.toString());
    try {
      return response.map((r) {
        final list = VitalMain.fromJson(r).data;
        // final result = VitalTopResult.fromJson({
        //   'list':list
        //   'showGraph': true,
        // });
        print(list);
        return list;
      }).toList();
    } catch (error) {
      print(error);
    }
  }
  //  @override
  // Future<List<VitalTopResult>> getVitalTypes(TypeParams params) async {
  //   String token = await SharedPreferenceHelper.getTokenPref();
  //   List<String> itemsIds = ['bp', 'sugar', 'spo2', 'ecg']; //different ids

  //   List<dynamic> response =
  //       await Future.wait(itemsIds.map((itemId) => _client.post(
  //             VITAL_TYPE,
  //             {...params.toJson(), 'type': itemId},
  //             token,
  //           )));
  //   // print('response ++++++++++++++++' + response.toString());
  //   try {
  //     // final data = json.decode(response);
  //     print(response);
  //     List<VitalTopResult> list = List<VitalTopResult>.from(response.map(
  //         (item) => VitalTopResult.fromJson(
  //             {'list': VitalMain.fromJson(item).data, 'showGraph': true})));

  //     print(list);
  //     return list;
  //   } catch (error) {
  //     print(error);
  //   }
  // }

}
