// import 'package:care4parents/helper/shareed_pref_key.dart';
import 'dart:convert';

import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/screens/subscription_add/bloc/subscription_add.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencenameKey = "nameKEY";
  static String sharedPreferenceContryCodeKey = "contryCodeKEY";

  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static const String sharePreferenceUserKey = "USERKEY";
  static const String sharePreferencePCKgeKey = "PACKGEKEY";
  static const String sharePreferenceCareCashgeKey = "CareCashKGEKEY";
  static const String sharePreferenceToken = "token";
  static const String sharePreferenceIsFirst = "IsFirst";
  static const String sharePreferenceSubscriptionKey = "SUBSCRIPTIONKEY";
  static const String sharePreferenceAppIdKey = "AppointmentIdKey";
  static const String sharePreferencePurchagepayIdKey = "purchaPayIdKey";
  static const String sharePreferencerozorPayIdKey = "rozorPayIdKey";
  static const String sharePreferenceBookSerIdKey = "BookserviceIdKey";
  static const String sharePreferenceBookSerNameKey = "BookserviceNameKey";
  static const String sharePreferencepackgeNameKey = "pckgeNameKey";
  static const String sharePreferenceMemberKey = "MEMERKEY";
  static const String sharePreferenceBannersKey = "BANNERKEY";
  static const String sharePreferenceFamilyKey = "FAMILYKEY";
  static const String sharePreferenceSMemberKey = "SELECTEDFAMILYKEY";
  static const String sharePreferenceMM = "membermobile";
  static const String sharePreferenceMG = "membergender";
  static const String sharePreferenceMN = "membername";

  static const String sharePreferenceCareCashreasonIdKey = "CareCashReasonKEY";
  static const String sharePreferenceCareCashgepatientIdKey =
      "CareCashpatientIdKEY";

  static Future<void> setMNPref(String membername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceMN, membername);
  }

  static Future<String> getMNPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(sharePreferenceMN) ?? null;
    return name;
  }

  static Future<void> setMGPref(String membergender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceMG, membergender);
  }

  static Future<String> getMGPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String membergender = prefs.getString(sharePreferenceMG) ?? null;
    return membergender;
  }

  static Future<void> setMMPref(String membermobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceMM, membermobile);
  }

  static Future<String> getMMPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String membermobile = prefs.getString(sharePreferenceMM) ?? null;
    return membermobile;
  }

  static Future<void> setTokenPref(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs?.setString(sharePreferenceToken, token) ?? null;
  }

  static Future<void> removeTokenPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs?.remove(sharePreferenceToken) ?? null;
  }

  static Future<String> getTokenPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(sharePreferenceToken) ?? null;
    return token;
  }

  static Future<bool> getIsFirstLoadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharePreferenceIsFirst) ?? false;
  }

  static Future<bool> setIsFirstLoadPref(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(sharePreferenceIsFirst, value);
  }

  static Future<void> setUserPref(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userData);
    await prefs.setString(sharePreferenceUserKey, userJson);
  }

  static Future<void> removeUserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharePreferenceUserKey);
  }

  static Future<void> setPackagePref(Package userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userData);
    await prefs.setString(sharePreferencePCKgeKey, userJson);
  }

  static Future<Package> getPackagePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString(sharePreferencePCKgeKey) ?? null;
    if (user == null || user == "null") {
      return null;
    } else {
      return Package.fromJson(jsonDecode(user));
    }
  }

  static Future<void> setCareCashAmountPref(String amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceCareCashgeKey, amount);
  }

  static Future<void> setCareCashpatientIdPref(String patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceCareCashgepatientIdKey, patientId);
  }

  static Future<void> setCareCashreasonPref(String reason) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceCareCashreasonIdKey, reason);
  }

  static Future<String> getCareCashAmountPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String amount = prefs.getString(sharePreferenceCareCashgeKey) ?? null;
    return amount;
  }

  static Future<String> getCareCashreasonPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String reason = prefs.getString(sharePreferenceCareCashreasonIdKey) ?? null;
    return reason;
  }

  static Future<String> getCareCashpatientIdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId =
        prefs.getString(sharePreferenceCareCashgepatientIdKey) ?? null;
    return patientId;
  }

  static Future<void> setFamilyPref(FamilyMember memberData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberJson = jsonEncode(memberData);
    await prefs.setString(sharePreferenceMemberKey, memberJson);
  }

  static Future<void> removeFamilyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharePreferenceMemberKey);
  }

  static Future<Banners> getBannersPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String banners = prefs.getString(sharePreferenceBannersKey) ?? null;

    return Banners.fromJson(jsonDecode(banners));
  }

  static Future<void> setBannersPref(Banners banners) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberJson = jsonEncode(banners);
    await prefs.setString(sharePreferenceBannersKey, memberJson);
  }

  static Future<List<FamilyMainResult>> getFamilyMermbersPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String banners = prefs.getString(sharePreferenceFamilyKey) ?? null;
    if (banners != null) {
      Iterable l = jsonDecode(banners);
      if (l != null) {
        List<FamilyMainResult> members = List<FamilyMainResult>.from(
            l.map((model) => FamilyMainResult.fromJson(model)));
        return members;
      }
    }
    return [];
  }

  static Future<void> setFamilyMermbersPref(
      List<FamilyMainResult> banners) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberJson = jsonEncode(banners);
    await prefs.setString(sharePreferenceFamilyKey, memberJson);
  }

  static Future<void> removeFamilyMermbersPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharePreferenceFamilyKey);
  }

  static Future<FamilyMember> getFamilyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String member = prefs.getString(sharePreferenceMemberKey) ?? null;
    if (member == null || member == "null") {
      return null;
    } else {
      return FamilyMember.fromJson(jsonDecode(member));
    }
  }

  static Future<void> setSelectedFamilyPref(FamilyMainResult member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberJson = jsonEncode(member);
    await prefs.setString(sharePreferenceSMemberKey, memberJson);
  }

  static Future<void> removeSelectedFamilyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharePreferenceSMemberKey);
  }

  static Future<FamilyMainResult> getSelectedFamilyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String member = prefs.getString(sharePreferenceSMemberKey) ?? null;
    if (member == null || member == "null") {
      return null;
    } else {
      return FamilyMainResult.fromJson(jsonDecode(member));
    }
  }

  static Future<User> getUserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString(sharePreferenceUserKey) ?? null;
    if (user == null || user == "null") {
      return null;
    } else {
      return User.fromJson(jsonDecode(user));
    }
  }

  static Future<void> setSubscriptionPref(SubscriptionAdd subData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String subJson = jsonEncode(subData);
    await prefs.setString(sharePreferenceSubscriptionKey, subJson);
  }

  static Future<void> removeSubscriptionPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sharePreferenceSubscriptionKey);
  }

  static Future<SubscriptionAdd> getSubscriptionPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String subscription =
        prefs.getString(sharePreferenceSubscriptionKey) ?? null;
    if (subscription == null || subscription == "null") {
      return null;
    } else {
      return SubscriptionAdd.fromJson(jsonDecode(subscription));
    }
  }

  static Future<void> setFlowSubscriptionPref(SubscriptionAdd subData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String subJson = jsonEncode(subData);
    await prefs.setString(sharePreferenceSubscriptionKey, subJson);
  }

  static Future<SubscriptionAdd> getFlowSubscriptionPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String subscription =
        prefs.getString(sharePreferenceSubscriptionKey) ?? null;
    if (subscription == null || subscription == "null") {
      return null;
    } else {
      return SubscriptionAdd.fromJson(jsonDecode(subscription));
    }
  }

  static Future<void> setAppointmentIdPref(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sharePreferenceAppIdKey, id);
  }

  static Future<int> getAppointmentIdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(sharePreferenceAppIdKey) ?? null;
    if (id == null || id == "null") {
      return null;
    } else {
      return id;
    }
  }

  static Future<void> setPurchagePaymentIdPref(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sharePreferencePurchagepayIdKey, id);
  }

  static Future<int> getPurchagePaymentIdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(sharePreferencePurchagepayIdKey) ?? null;
    if (id == null || id == "null") {
      return null;
    } else {
      return id;
    }
  }

  static Future<void> setPurchageRozorPayRESPref(
      RozorPayMappingParams id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferencerozorPayIdKey, jsonEncode(id));
  }

  static Future<RozorPayMappingParams> getPurchageRozorPayRESPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(sharePreferencerozorPayIdKey) ?? null;
    if (id == null || id == "null") {
      return null;
    } else {
      return RozorPayMappingParams.fromJson(jsonDecode(id));
    }
  }

  static Future<void> setBookServiceName(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferenceBookSerNameKey, id);
  }

  static Future<String> getBookServiceName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(sharePreferenceBookSerNameKey) ?? null;
    if (id == null || id == "null") {
      return "";
    } else {
      return id;
    }
  }

  static Future<void> setPckgeName(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharePreferencepackgeNameKey, id);
  }

  static Future<String> getPckgeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(sharePreferencepackgeNameKey) ?? null;
    if (id == null || id == "null") {
      return "";
    } else {
      return id;
    }
  }

  static Future<void> setBookServiceIdPref(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sharePreferenceBookSerIdKey, id);
  }

  static Future<int> getBookServiceIdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(sharePreferenceBookSerIdKey) ?? null;
    if (id == null || id == "null") {
      return null;
    } else {
      return id;
    }
  }

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveNameSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencenameKey, name);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencenameKey);
  }

  static Future<String> getContryCodeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceContryCodeKey);
  }

  static Future<bool> saveContryCodeSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceContryCodeKey, name);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }
}
