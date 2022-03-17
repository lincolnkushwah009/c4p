import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/array_common_result.dart';
import 'package:care4parents/data/models/coupon_code.dart';
import 'package:care4parents/data/models/coupon_code_result.dart';
import 'package:care4parents/data/models/member_result.dart';
import 'package:care4parents/data/models/member_service_mapping_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/order_result.dart';
import 'package:care4parents/data/models/rozar_pay_result.dart';
import 'package:care4parents/data/models/update_family_member_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/data/models/user_package_mapping_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/no_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/subscription_add/bloc/subscription_add.dart';
import 'package:care4parents/util/config.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionFlowBloc extends FormBloc<String, String> {
  final GetPackage getPackages;
  final CreateFamilyMember createFamilyMember;
  final CreateFamilyMapping createFamilyMapping;
  final CreateOrder createOrder;
  final CreateUserPackageMapping createUserPackageMapping;
  final UpdateFamilyMember updateFamilyMember;
  final MemberServcieMapping memberServcieMapping;
  final CodeVerification codeVerification;
  final UpdateOrders updateOrders;
  final CreateRozerPayOrder createRozerPayOrder;
  Razorpay _razorpay;

  var order_id;
  final fullname = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ],
  );

  final firstName = TextFieldBloc();

  final lastName = TextFieldBloc();

  final gender = SelectFieldBloc(
    items: ['Male', 'Female'],
    validators: [FieldBlocValidators.required],
  );

  final package_id = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final package_price = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final discountAmount = TextFieldBloc();
  final promocode_name = TextFieldBloc();
  final promocode_id = TextFieldBloc();

  final package_name = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final package_code = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final package_duration = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final coupon_code = TextFieldBloc(
      // validators: [FieldBlocValidators.required],
      );
  final relation = SelectFieldBloc(
    items: [
      'Father',
      'Mother',
      'Father-In-Law',
      'Mother-In-Law',
      'Son',
      'Daughter',
      'Husband',
      'Wife',
      'Brother',
      'Sister',
      'Grandfather',
      'Grandmother',
      'Grandson',
      'Granddaughter',
      'Uncle',
      'Aunt',
      'Nephew',
      'Niece',
      'Cousin',
      'Self',
      'Other'
    ],
    validators: [FieldBlocValidators.required],
    asyncValidatorDebounceTime: Duration(milliseconds: 50),

    //     const relations = [
    //   { name: 'Father', gender: gender[0] },
    //   { name: 'Mother', gender: gender[1] },
    //   { name: 'Son', gender: gender[0] },
    //   { name: 'Daughter', gender: gender[1] },
    //   { name: 'Husband', gender: gender[0] },
    //   { name: 'Wife', gender: gender[1] },
    //   { name: 'Brother', gender: gender[0] },
    //   { name: 'Sister', gender: gender[1] },
    //   { name: 'Grandfather', gender: gender[0] },
    //   { name: 'Grandmother', gender: gender[1] },
    //   { name: 'Grandson', gender: gender[0] },
    //   { name: 'Granddaughter', gender: gender[1] },
    //   { name: 'Uncle', gender: gender[0] },
    //   { name: 'Aunt', gender: gender[1] },
    //   { name: 'Nephew', gender: gender[0] },
    //   { name: 'Niece', gender: gender[1] },
    //   { name: 'Cousin', gender: gender[0] },
    //   { name: 'Self', gender: '' },
    //   { name: 'Other', gender: '' },
    // ]
  );

  final dateOfBirth = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );

  final address = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final phone = TextFieldBloc(
    validators: [FieldBlocValidators.required, _phoneNumberValidator],
  );

  final pincode = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final states = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  static String _phoneNumberValidator(String text) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (text == null ||
        text == false ||
        (!regExp.hasMatch(text)) && text.length < 10) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  final emergency_contact_person = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final emergency_contact_no = TextFieldBloc(
    validators: [FieldBlocValidators.required, _phoneNumberValidator],
  );

  SubscriptionFlowBloc({
    @required this.getPackages,
    @required this.createFamilyMember,
    @required this.createFamilyMapping,
    @required this.createOrder,
    @required this.createUserPackageMapping,
    @required this.updateFamilyMember,
    @required this.memberServcieMapping,
    @required this.codeVerification,
    @required this.updateOrders,
    @required this.createRozerPayOrder,
  }) : super(isLoading: true, isEditing: true, autoValidate: true) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    addFieldBlocs(
      step: 2,
      fieldBlocs: [fullname, relation, gender, dateOfBirth],
    );
    relation.addAsyncValidators(
      [_updateGender],
    );
    addFieldBlocs(
      step: 3,
      fieldBlocs: [
        email,
        address,
        phone,
        emergency_contact_person,
        emergency_contact_no,
        pincode,
        states
      ],
    );

    addFieldBlocs(
      step: 0,
      fieldBlocs: [
        package_id,
        package_price,
        package_name,
        package_duration,
        package_code
      ],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [package_id, coupon_code],
    );
  }

  Future<String> _updateGender(String relation) async {
    String value = '';
    switch (relation) {
      case 'Father':
      case 'Father-In-Law':
      case 'Son':
      case 'Husband':
      case 'Brother':
      case 'Grandfather':
      case 'Grandson':
      case 'Uncle':
      case 'Nephew':
        value = 'Male';
        break;
      case 'Mother':
      case 'Mother-In-Law':
      case 'Daughter':
      case 'Wife':
      case 'Sister':
      case 'Grandmother':
      case 'Granddaughter':
      case 'Aunt':
      case 'Niece':
      case 'Cousin':
        value = 'Female';
        break;
      case 'Self':
      case 'Other':
        value = '';
        break;
    }
    if (value != '') {
      gender.updateInitialValue(value);
    } else {
      gender.updateValue(null);
    }

    return null;
  }

  saveData() async {
    SubscriptionAdd subscriptionAdd = new SubscriptionAdd(
      currentStep: state.currentStep,
      fullName: fullname.value,
      gender: gender.value,
      relation: relation.value,
      dateOfBirth: dateOfBirth.value.toString(),
      email: email.value,
      pincode: pincode.value,
      state: states.value,
      address: address.value,
      phone: phone.value,
      contactPerson: emergency_contact_person.value,
      contactNo: emergency_contact_no.value,
      package_id: (package_id.value != '' || package_id.value != 'null')
          ? int.tryParse(package_id.value)
          : null,
      package_name: (package_name.value != '') ? package_name.value : null,
      package_duration:
          (package_duration.value != '' || package_duration.value != null)
              ? package_duration.value
              : null,
      package_code: (package_code.value != '' || package_code.value != null)
          ? package_code.value
          : null,
      package_price: (package_price.value != '' || package_price.value != null)
          ? int.tryParse(package_price.value)
          : null,
      discountAmount:
          (discountAmount.value != '' || discountAmount.value != null)
              ? int.tryParse(discountAmount.value)
              : null,
      promocode_id: (promocode_id.value != '' || promocode_id.value != null)
          ? int.tryParse(promocode_id.value)
          : null,
      promocode_name:
          (promocode_name.value != '' || promocode_name.value != null)
              ? promocode_name.value
              : null,
    );

    await SharedPreferenceHelper.setSubscriptionPref(subscriptionAdd);
  }

  updatePackage(package) {
    package..updateInitialValue(package);
  }

  @override
  void onSubmitting() async {
    saveData();
    if (state.currentStep == 0) {
      emitSuccess();
    } else if (state.currentStep == 1) {
      emitSuccess();
    } else if (state.currentStep == 2) {
      emitSuccess();
    } else if (state.currentStep == 3) {
      // final Either<AppError, RozarPayResult> eitherROrder =
      //     await createRozerPayOrder(100);
      // eitherROrder.fold((l) {
      //   print('left error createOrder Rozarpay>>>>>' + l.toString());
      //   emitFailure();
      // }, (r_order) async {
      //   openCheckout(r_order.id);
      // });
      // await openCheckout();
      await createMember();
      // SubscriptionAdd subscriptionAdd = new SubscriptionAdd();
      // await SharedPreferenceHelper.setSubscriptionPref(subscriptionAdd);
      // emitSuccess();
    }
  }

  @override
  void previousStep() {
    super.previousStep();
  }

  int getCurrentStep() {
    return state.currentStep;
  }

  @override
  Future<void> onLoading() async {
    super.onLoading();
    try {
      // SubscriptionAdd subscriptionAdd = SubscriptionAdd();
      // await SharedPreferenceHelper.setSubscriptionPref(subscriptionAdd);

      // await getPackageList();
      SubscriptionAdd subscriptionAdd =
          await SharedPreferenceHelper.getSubscriptionPref();
      if (subscriptionAdd != null) {
        print('subscriptionAdd.currentStep' +
            subscriptionAdd.currentStep.toString());
        updateCurrentStep(subscriptionAdd.currentStep != null
            ? subscriptionAdd.currentStep
            : 0);
        fullname.updateInitialValue(subscriptionAdd.fullName);
        gender.updateInitialValue(subscriptionAdd.gender);
        relation.updateInitialValue(subscriptionAdd.relation);
        dateOfBirth
          ..updateInitialValue(DateTime.parse(subscriptionAdd.dateOfBirth));
        email.updateInitialValue(subscriptionAdd.email);
        address.updateInitialValue(subscriptionAdd.address);
        phone.updateInitialValue(subscriptionAdd.phone);
        pincode.updateInitialValue(subscriptionAdd.pincode);
        states.updateInitialValue(subscriptionAdd.state);
        emergency_contact_person
            .updateInitialValue(subscriptionAdd.contactPerson);
        emergency_contact_no.updateInitialValue(subscriptionAdd.contactNo);
        package_price
            .updateInitialValue(subscriptionAdd.package_price.toString());
        package_id.updateInitialValue(subscriptionAdd.package_id.toString());
        package_name
            .updateInitialValue(subscriptionAdd.package_name.toString());
        package_code
            .updateInitialValue(subscriptionAdd.package_code.toString());
        package_duration
            .updateInitialValue(subscriptionAdd.package_duration.toString());
        discountAmount
            .updateInitialValue(subscriptionAdd.discountAmount.toString());
        promocode_id
            .updateInitialValue(subscriptionAdd.promocode_id.toString());
        promocode_name
            .updateInitialValue(subscriptionAdd.promocode_name.toString());
      }
      emitLoaded();
    } catch (error) {
      emitLoadFailed();
    }
  }

  Future<List<Package>> getPackageList() async {
    try {
      final Either<AppError, List<Package>> eitherResponse =
          await getPackages(NoParams());
      return eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          emitFailure();
        },
        (packagesList) {
          emitLoaded();
          return packagesList;
        },
      );
    } on Exception catch (error) {
      print('Exception >>>>>>' + error.toString());
      emitLoadFailed();
    }
    emitLoaded();
    return [];
  }

  Future<CouponCode> checkCouponValid() async {
    try {
      print(package_price.value);
      final Either<AppError, CouponCodeResult> eitherResponse =
          await codeVerification(CouponCodeParams(
        code: coupon_code.value,
        package_id: package_id.valueToInt,
        amount: int.parse(package_price.value),
      ));
      return eitherResponse.fold(
        (l) {
          coupon_code.updateInitialValue('');
          var amount = int.tryParse(package_price.value);
          if (discountAmount.value != null) {
            amount = int.tryParse(package_price.value) +
                int.tryParse(discountAmount.value);
          }

          discountAmount.updateInitialValue('');
          promocode_id.updateInitialValue('');
          promocode_name.updateInitialValue('');
          package_price.updateInitialValue(amount.toString());

          return Future.error(l.message);
        },
        (result) {
          coupon_code.updateInitialValue('');
          if (result.coupon.id != null) {
            discountAmount.updateInitialValue(result.amount.toString());
            promocode_id.updateInitialValue(result.coupon.id.toString());
            promocode_name.updateInitialValue(result.coupon.name);
            if (result.amount != null) {
              var amount = int.tryParse(package_price.value) - result.amount;
              package_price.updateInitialValue(amount.toString());
            }
          }
          return result.coupon;
        },
      );
    } on Exception catch (error) {
      print('Exception >>>>>>' + error.toString());
      emitLoadFailed();
    }
    return null;
  }

  Future<void> createMember() async {
    int duration = int.parse(package_duration.value.split(' ')[0]);
    final DateTime today = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime after_date =
        new DateTime(today.year, today.month + duration, today.day);
    final String start_date = formatter.format(today);
    final String end_date = formatter.format(after_date);
    print('end_date' + end_date.toString());
    print('start_date' + start_date.toString());

    try {
      final Either<AppError, MemberResultModel> eitherResponse =
          await createFamilyMember(MemberParams(
              name: fullname.value,
              relation: relation.value,
              gender: gender.value,
              dob: dateOfBirth.value.toString(),
              email: email.value,
              address: address.value,
              phone: phone.value,
              emergency_contact_person: emergency_contact_person.value,
              emergency_contact_no: emergency_contact_no.value,
              emergency_country_code: '91'));
      eitherResponse.fold(
        (l) {
          print('left error createFamilyMember>>>>>');
          emitFailure();
        },
        (member) async {
          //create family mapping
          print('member' + member.toString());
          final Either<AppError, ObjectCommonResult> familyMappingResponse =
              await createFamilyMapping(
                  MemberMappingParams(family_member_id: member.id));
          familyMappingResponse.fold((l) {
            print('left error createFamilyMapping>>>>>');
            emitFailure();
          }, (r) async {
            if (r.confirmation == 'success') {
              var now = new DateTime.now().toUtc();
              print('order_date_time' + now.toString());
              print('package_price.value' + package_price.value.toString());
              print('discountAmount.value' +
                  int.tryParse(discountAmount.value).toString());
              print('package_price.valueToDouble.round()' +
                  package_price.valueToDouble.round().toString());
              //create order
              if (int.tryParse(discountAmount.value).toString() != 'null') {
                print('in =================>' +
                    (int.tryParse(package_price.value) -
                            int.tryParse(discountAmount.value))
                        .toString());
              }

              final Either<AppError, OrderResult> eitherOrder =
                  await createOrder(OrderParams(
                pincode: pincode.value,
                package: package_code.value,
                quantity: 1,
                name: fullname.value,
                order_datetime: now.toString(),
                phone: phone.value,
                state: states.value,
                status: (package_price.valueToDouble.round() > 0)
                    ? 'PENDING'
                    : 'COMPLETED',
                address: address.value,
                family_member: member.id,
                amount:
                    (int.tryParse(discountAmount.value).toString() != 'null')
                        ? (int.tryParse(package_price.value) - int.tryParse(discountAmount.value))
                        : int.tryParse(package_price.value),
                discount_amount: (discountAmount.value != null &&
                        int.tryParse(discountAmount.value).toString() != 'null')
                    ? discountAmount.value
                    : '0',
                promocode_name: (promocode_name.value != 'null')
                    ? promocode_name.value
                    : null,
                promocode_id: (promocode_id.value != null)
                    ? int.tryParse(promocode_id.value)
                    : null,

                // coupon fields
              ));
              eitherOrder.fold((l) {
                print('left error createOrder>>>>>' + l.toString());
                emitFailure();
              }, (order) async {
                if (order.id != null) {
                  // TODO: when payment is required.
                  // rozar pay
                  // updateOrders
                  if (package_price.valueToInt > 0) {
                    order_id = order.id;
                    final Either<AppError, RozarPayResult> eitherROrder =
                        await createRozerPayOrder(package_price.valueToInt);
                    eitherROrder.fold((l) {
                      print('left error createOrder Rozarpay>>>>>' +
                          l.toString());
                      emitFailure();
                    }, (r_order) async {
                      openCheckout(r_order.id);
                    });
                  } else {
                    print('package_id.valueToInt' +
                        package_id.valueToInt.toString());
                    //create other non paymet apis
                    final Either<AppError, UserPackageMappingResult>
                        createUserPackageMappingRes =
                        await createUserPackageMapping(UserPackageMappingParams(
                            package: package_code.value,
                            family_member: member.id.toString(),
                            order: order.id.toString(),
                            start_date: start_date,
                            end_time: end_date,
                            status: true));
                    createUserPackageMappingRes.fold((l) {
                      print('left error createUserPackageMapping>>>>>');
                      emitFailure();
                    }, (userPackageMapping) async {
                      print('userPackageMapping ===========>' +
                          userPackageMapping.toJson().toString());

                      final Either<AppError, ObjectCommonResult>
                          updateMemberResponse =
                          await updateFamilyMember(UpdateMemberParams(
                        user_package_mapping: userPackageMapping.id.toString(),
                        family_member_id: member.id.toString(),
                      ));
                      updateMemberResponse.fold((l) {
                        print('left error updateFamilyMember>>>>>');
                        emitFailure();
                      }, (updateFamilyMember) async {
                        print('updateFamilyMember ===========>' +
                            updateFamilyMember.toJson().toString());

                        final Either<AppError, ArrayCommonResult>
                            serviceMappingResponse = await memberServcieMapping(
                                CreateServiceMappingParams(
                          package: package_code.value,
                          family_member_id: member.id,
                          member_name: fullname.value,
                          member_phone: phone.value,
                        ));
                        serviceMappingResponse.fold((l) {
                          print('left error memberServcieMapping>>>>>');
                          emitFailure();
                        }, (serviceMapping) async {
                          print('memberServcieMapping ===========>' +
                              serviceMapping.toJson().toString());
                          //clean local data.
                          SubscriptionAdd subscriptionAdd =
                              new SubscriptionAdd();
                          await SharedPreferenceHelper.setSubscriptionPref(
                              subscriptionAdd);

                          emitSuccess();
                        });
                      });
                    });
                  }
                }
              });
            }
          });
          emitLoaded();
        },
      );
    } catch (error) {
      emitFailure();
      print('Exception >>>>>>' + error.toString());
      // emitLoadFailed();
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded" + response.toString());
    print("SUCCESS: paymentId >" + response.paymentId); //pay_Gs0KZzJFqUOJ4J
    print("SUCCESS: orderId >" + response.orderId);
    if (response.orderId != null) {
      final Either<AppError, ObjectCommonResult> updateOrder =
          await updateOrders(order_id);
      updateOrder.fold((l) {
        print('left error updateOrders>>>>>' + l.toString());
        emitFailure();
      }, (orderResult) async {
        print('updateOrders ===========>' + orderResult.toJson().toString());
        //clean local data.
        SubscriptionAdd subscriptionAdd = new SubscriptionAdd();
        await SharedPreferenceHelper.setSubscriptionPref(subscriptionAdd);
        emitSuccess();
      });
    } else {
      emitFailure();
    }

    emitSuccess();
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    emitFailure();
    // ExtendedNavigator.root.pop((route) => true);
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");
    emitFailure();

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  void openCheckout(order_id) async {
    User user_data = await SharedPreferenceHelper.getUserPref();
    var options = {
      'key': CONFIG.ROZAR_PAY_KEY,
      'order_id': order_id,
      'amount': 1 * 100,
      // 'amount': 1 * 100,
      "name": CONFIG.ROZAR_PAY_NAME,
      "description": CONFIG.ROZAR_PAY_DESC,
      "image": CONFIG.ROZAR_PAY_IMAGE,
      "modal": {},
      "theme": {
        "color": CONFIG.ROZAR_PAY_THEME_COLOR,
      },
      "notify": {"sms": false, "email": true},
      'prefill': {'contact': user_data.phone_number, 'email': user_data.email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Encountered error:" + e);
    }
  }
}
