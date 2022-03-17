import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/package.dart';

import 'package:care4parents/presentation/layout/adaptive.dart';

import 'package:care4parents/presentation/screens/subscription_add/view/package_item.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';

import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/loading_dialog.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';

import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:intl/intl.dart';

import '../index.dart';

final formatCurrency =
    new NumberFormat.currency(symbol: '₹ ', decimalDigits: 0);

// https://github.com/GiancarloCode/form_bloc/issues/64

class SubscriptionFlowScreen extends StatefulWidget {
  @override
  _SubscriptionAddScreenState createState() => _SubscriptionAddScreenState();
}

class _SubscriptionAddScreenState extends State<SubscriptionFlowScreen> {
  var _type = StepperType.horizontal;
  final _couponList = <String>[];

  var isLoading = true;
  String errorCode = null;
  String _isCouponError = null;
  String _isCouponSuccess = null;
  var _isSubmitLoading = false;
  List<Package> packageList = [];
  SubscriptionFlowBloc _subscriptionFlowBloc;

  @override
  initState() {
    super.initState();
    _subscriptionFlowBloc = getItInstance<SubscriptionFlowBloc>();
    init();
  }

  Future<void> init() async {
    await _subscriptionFlowBloc.getPackageList().then((packages) {
      if (packages != null) {
        packageList = packages;
        print('packageList lenght' + packageList.length.toString());
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return isLoading
        ? Container(
            height: heightOfScreen,
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: AppLoading(),
          )
        : BlocProvider(
            create: (context) => _subscriptionFlowBloc,
            child: Builder(
              builder: (context) {
                final loadingFormBloc =
                    BlocProvider.of<SubscriptionFlowBloc>(context);
                return Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: commonInputDecoration(context, theme),
                  ),
                  child: Scaffold(
                    // resizeToAvoidBottomInset: false,
                    backgroundColor: AppColors.white,
                    appBar: PreferredSize(
                        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                        child: CustomAppBar(
                            title: StringConst.ADD_SUBSCRIPTION_SCREEN,
                            leading: InkWell(
                              onTap: () {
                                if (loadingFormBloc.getCurrentStep() == 0) {
                                  ExtendedNavigator.root.pop();
                                } else {
                                  loadingFormBloc.previousStep();
                                }
                              },
                              child: Icon(Icons.arrow_back_ios),
                            ),
                            trailing: [new whatappIconwidget(isHeader: true)],
                            hasTrailing: true)),
                    body: SafeArea(
                      child: FormBlocListener<SubscriptionFlowBloc, String,
                          String>(
                        onLoading: (context, state) =>
                            {LoadingDialog.show(context)},
                        onSubmitting: (context, state) => {
                          LoadingDialog.show(context),
                        },
                        onSuccess: (context, state) {
                          LoadingDialog.hide(context);
                          if (state.stepCompleted == state.lastStep) {
                            ExtendedNavigator.root.pop();
                            // ExtendedNavigator.root.pop(Routes.familyListScreen);
                          }
                        },
                        onFailure: (context, state) {
                          print('onFailure called');
                          SnackBarWidgets.buildErrorSnackbar(context,
                              'Error in subscription create. Try later.');
                          LoadingDialog.hide(context);
                        },
                        child: StepperFormBlocBuilder<SubscriptionFlowBloc>(
                          type: _type,
                          physics: ClampingScrollPhysics(),
                          stepsBuilder: (formBloc) {
                            return [
                              _packageStep(formBloc),
                              _personalStep(formBloc),
                              _accountStep(formBloc),
                              _finalSummaryStep(formBloc),
                            ];
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  InputDecorationTheme commonInputDecoration(
      BuildContext context, ThemeData theme) {
    return InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColors.blackShade6,
            ),
        labelStyle: theme.textTheme.subtitle1.copyWith(
          color: AppColors.secondaryColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyShade3.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyShade3),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redShade5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: AppColors.greyShade3.withOpacity(0.7),
        focusColor: AppColors.greyShade3);
  }

  InputDecorationTheme cInputDecoration(BuildContext context, ThemeData theme) {
    return InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColors.blackShade6,
            ),
        labelStyle: theme.textTheme.subtitle1.copyWith(
          color: AppColors.red,
          letterSpacing: 2.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.redShade5),
        ),
        filled: false,
        // fillColor: AppColors.greyShade3.withOpacity(0.7),
        focusColor: AppColors.greyShade3);
  }

  FormBlocStep _personalStep(SubscriptionFlowBloc subscriptionAddFormBloc) {
    return FormBlocStep(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            StringConst.sentence.EAMD,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.greyShade6),
          ),
          TitleText(title: StringConst.label.MEMBER_NAME, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.PEMN,
            textFieldBloc: subscriptionAddFormBloc.fullname,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: StringConst.label.FULL_NAME,
            ),
            style: styleInput(context),
          ),
          TitleText(title: StringConst.label.RELATION, context: context),
          DropdownFieldBlocBuilder<String>(
            errorBuilder: (context, error) => StringConst.sentence.PER,
            selectFieldBloc: subscriptionAddFormBloc.relation,
            decoration: InputDecoration(
              hintText: StringConst.label.RELATION,
              hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.blackShade6, fontWeight: FontWeight.w500),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.blackShade7,
              ),
            ),
            itemBuilder: (context, value) => value as dynamic,
            textStyle: styleInput(context),
          ),
          TitleText(
              title: StringConst.label.DATE_OF_BIRTHDAY, context: context),
          DateTimeFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.PEDOB,
            dateTimeFieldBloc: subscriptionAddFormBloc.dateOfBirth,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            format: DateFormat('yyyy-MM-dd'),
            decoration: InputDecoration(
              hintText: StringConst.label.DATE_OF_BIRTHDAY,
              hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.blackShade6, fontWeight: FontWeight.w500),
              suffixIcon: Icon(
                Icons.calendar_today_rounded,
                color: AppColors.blackShade10.withOpacity(0.7),
              ),
            ),
            textStyle: styleInput(context),
          ),
          TitleText(title: StringConst.label.GENDER, context: context),
          DropdownFieldBlocBuilder<String>(
            errorBuilder: (context, error) => StringConst.sentence.PEG,
            selectFieldBloc: subscriptionAddFormBloc.gender,
            decoration: InputDecoration(
              hintText: StringConst.label.GENDER,
              hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.blackShade6, fontWeight: FontWeight.w500),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.blackShade7,
              ),
            ),
            itemBuilder: (context, value) => value as dynamic,
            textStyle: styleInput(context),
          ),
        ],
      ),
    );
  }

  FormBlocStep _accountStep(SubscriptionFlowBloc subscriptionAddFormBloc) {
    double height = assignHeight(context: context, fraction: 1.0);
    return FormBlocStep(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            StringConst.sentence.EACD,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.greyShade6),
          ),
          TitleText(title: StringConst.label.MEMBER_EMAIL, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) {
              switch (error) {
                case FieldBlocValidatorsErrors.required:
                  return StringConst.sentence.PEE;
                default:
                  return StringConst.sentence.PEVE;
              }
            },
            // errorBuilder: (context, error) => StringConst.sentence.PEE,
            textFieldBloc: subscriptionAddFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: StringConst.label.EMAIL,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(title: StringConst.label.MEMBER_ADDRESS, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.PEA,
            textFieldBloc: subscriptionAddFormBloc.address,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: StringConst.label.ADDRESS,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(title: StringConst.label.MEMBER_PHONE, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) {
              switch (error) {
                case FieldBlocValidatorsErrors.required:
                  return StringConst.sentence.PEPN;
                default:
                  return StringConst.sentence.EVCN;
              }
            },
            textFieldBloc: subscriptionAddFormBloc.phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: StringConst.label.PHONE_NUMBER,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(
              title: StringConst.label.EMERGENCY_CONTACT_PERSON,
              context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.ECP,
            textFieldBloc: subscriptionAddFormBloc.emergency_contact_person,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: StringConst.label.FULL_NAME,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(
              title: StringConst.label.EMERGENCY_CONTACT_NO, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) {
              switch (error) {
                case FieldBlocValidatorsErrors.required:
                  return StringConst.sentence.ECN;
                default:
                  return StringConst.sentence.EVCN;
              }
            },
            textFieldBloc: subscriptionAddFormBloc.emergency_contact_no,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: StringConst.label.PHONE_NUMBER,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(title: StringConst.label.PINCODE, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.EPC,
            textFieldBloc: subscriptionAddFormBloc.pincode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: StringConst.label.PINCODE,
            ),
            textStyle: styleInput(context),
          ),
          TitleText(title: StringConst.label.STATE, context: context),
          TextFieldBlocBuilder(
            errorBuilder: (context, error) => StringConst.sentence.PES,
            textFieldBloc: subscriptionAddFormBloc.states,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: StringConst.label.STATE,
            ),
            textStyle: styleInput(context),
          ),
        ],
      ),
    );
  }

  FormBlocStep _packageStep(SubscriptionFlowBloc subscriptionAddFormBloc) {
    double height = assignHeight(context: context, fraction: 1.0);

    return FormBlocStep(
      title: Text(''),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            StringConst.sentence.SPFM,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.greyShade6),
          ),
          if (packageList.length != 0)
            Container(
              height: height * 0.75,
              child: new ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: packageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    // splashColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        packageList
                            .forEach((element) => element.isSelected = false);
                        packageList[index].isSelected = true;
                      });
                      subscriptionAddFormBloc.package_id
                          .updateInitialValue(packageList[index].id.toString());
                      subscriptionAddFormBloc.package_price.updateInitialValue(
                          packageList[index].price.toString());
                      subscriptionAddFormBloc.package_name
                          .updateInitialValue(packageList[index].name);
                      subscriptionAddFormBloc.package_code
                          .updateInitialValue(packageList[index].code);
                      subscriptionAddFormBloc.package_duration
                          .updateInitialValue(packageList[index].duration);
                    },
                    child: PackageItem(packageList[index],
                        subscriptionAddFormBloc.package_id.valueToInt),
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  FormBlocStep _finalSummaryStep(SubscriptionFlowBloc subscriptionAddFormBloc) {
    double height = assignHeight(context: context, fraction: 1.0);
    double width = assignWidth(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    return FormBlocStep(
      title: Text(''),
      content: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: cInputDecoration(context, theme),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              subscriptionAddFormBloc.package_price.value != null &&
                      subscriptionAddFormBloc.package_price.value != '' &&
                      subscriptionAddFormBloc.package_price.value != "null"
                  ? StringConst.label.PACKAGE_AMOUNT +
                      ": ${formatCurrency.format(int.parse(subscriptionAddFormBloc.package_price.value))}"
                  : '0',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.black),
              textAlign: TextAlign.start,
            ),
            SpaceH16(),
            SummaryItem(
              context: context,
              label: StringConst.label.PACKAGE,
              value: subscriptionAddFormBloc.package_name.value,
            ),
            SpaceH8(),
            SummaryItem(
              context: context,
              label: StringConst.label.MEMBER_ADDRESS,
              value: subscriptionAddFormBloc.address.value,
            ),
            SpaceH8(),
            SummaryItem(
              context: context,
              label: StringConst.label.MEMBER_PHONE,
              value: subscriptionAddFormBloc.phone.value,
            ),
            SpaceH8(),
            SummaryItem(
              context: context,
              label: StringConst.label.PINCODE,
              value: subscriptionAddFormBloc.pincode.value,
            ),
            SpaceH8(),
            SummaryItem(
              context: context,
              label: StringConst.label.STATE,
              value: subscriptionAddFormBloc.states.value,
            ),
            SpaceH24(),
            if (_isCouponSuccess != null)
              Text(
                _isCouponSuccess,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: AppColors.greenShade2,
                    ),
              ),
            if (subscriptionAddFormBloc.package_price.value != '0' ||
                _isCouponSuccess != null)
              BgCard(
                width: width * 0.8,
                height: 230,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(Sizes.RADIUS_10),
                ),
                child: Column(
                  children: [
                    TitleText(
                        title: StringConst.sentence.ECC, context: context),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: TextFieldBlocBuilder(
                        textCapitalization: TextCapitalization.characters,
                        errorBuilder: (context, error) =>
                            StringConst.sentence.PECC,
                        textFieldBloc: subscriptionAddFormBloc.coupon_code,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 3.0),
                      ),
                    ),
                    // if (errorCode != null)
                    //   Text(
                    //     errorCode,
                    //     style: Theme.of(context).textTheme.caption.copyWith(
                    //           color: AppColors.redShade5,
                    //         ),
                    //   ),
                    _isSubmitLoading
                        ? AppLoading()
                        : RoundSecondaryButton(
                            onPressed: () {
                              if (subscriptionAddFormBloc.coupon_code.value ==
                                  '') {
                                setState(() {
                                  errorCode = 'Enter Coupon Code';
                                });
                              } else {
                                setState(() {
                                  errorCode = null;
                                });
                                print('code>>>>' +
                                    subscriptionAddFormBloc.coupon_code.value);
                                onPressAppy(
                                    subscriptionAddFormBloc.coupon_code.value);
                              }
                            },
                            title: CommonButtons.APPLY,
                            theme: theme,
                            backgroundColor: AppColors.primaryColor,
                            textColor: AppColors.white,
                          ),
                    if (_isCouponError != null)
                      Text(
                        _isCouponError,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: AppColors.redShade5,
                            ),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  TextStyle styleInput(context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontWeight: FontWeight.w700);
  }

  Future<void> onPressAppy(code) async {
    if (_couponList.contains(code)) {
      setState(() {
        _isCouponError = 'Already applied this code';
        _isCouponSuccess = null;
        _isSubmitLoading = false;
      });
    } else {
      setState(() {
        _isSubmitLoading = true;
      });

      await _subscriptionFlowBloc.checkCouponValid().then((result) {
        print(result);
        if (result != null) {
          setState(() {
            _couponList.add(result.name);
            _isCouponSuccess = 'Coupon code applied successfully!';
            _isCouponError = null;
            _isSubmitLoading = false;
          });
        }
      }).catchError((error) {
        print('error in onPressAppy ======>' + error.toString());
        setState(() {
          _isCouponError = 'Invalid Coupon code';
          _isCouponSuccess = null;
          _isSubmitLoading = false;
        });
      });
    }
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    Key key,
    @required this.context,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  final BuildContext context;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.black,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.black,
                ),
          ),
        ),
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
    @required this.context,
    @required this.title,
  }) : super(key: key);

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
    );
  }
}
