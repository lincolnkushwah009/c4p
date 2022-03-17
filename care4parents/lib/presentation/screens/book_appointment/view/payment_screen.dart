import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/screens/book_appointment/bloc/book_appointment_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_add/view/subscription_add_screen.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/bg_card_auto.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/loading_dialog.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/util/config.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../data/models/coupon_code_result.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../widgets/booking_text_form_field.dart';

class AppointmentPayment extends StatefulWidget {
  final int appointment_id;
  String type;

  Package pckgitem;
  AppointmentPayment({this.appointment_id, this.type, this.pckgitem}) : super();

  @override
  _AppointmentPaymentState createState() => _AppointmentPaymentState();
}

class _AppointmentPaymentState extends State<AppointmentPayment> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  BookAppointmentBloc bookAppointmentBloc;
  String amt = "", coupon_code = "";
  String errorCode = null;
  // String _isCouponError = null;
  String _couponSuccess = null;
  var _isSubmitLoading = false;
  String pkg_id = "";
  int pkg_amount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAppointmentBloc = getItInstance<BookAppointmentBloc>();
    if (widget.type == "bookAppointment") {
      pkg_id = 'a';
    }
    if (widget.type == "bookservice") {
      pkg_id = 'b';
    }

    print("  payyyyyy screeen  Payment type>>type   " + widget.type.toString());
    if (widget.type == "bookAppointment" || widget.type == "bookservice") {
      bookAppointmentBloc.add(GetPaymentFee(widget.appointment_id));
    }

    if (widget.type == "purchagePlan") {
      print("  AppointmentPayment pckgitem>>type   " +
          widget.pckgitem.price.toString());
      pkg_id = widget.pckgitem.id.toString();
      pkg_amount = widget.pckgitem.price;
      print("  AppointmentPayment pckgitem>>type   " +
          widget.pckgitem.type.toString());
      print("  AppointmentPayment pckgitem>>type   " +
          widget.pckgitem.id.toString());
      savePcg();
    } else if (widget.type == "CareCash") {
      getCareCashAmt();
    }
  }

  getCareCashAmt() async {
    amt = await SharedPreferenceHelper.getCareCashAmountPref();

    setState(() {
      pkg_amount = int.parse(amt);
    });
  }

  savePcg() async {
    await SharedPreferenceHelper.setPackagePref(widget.pckgitem);
  }

  // final _couponList = <String>[];
  Future<void> onPressApply(code) async {
    await bookAppointmentBloc.add(CheckCouponValid(code, pkg_id, pkg_amount));
    // if (_couponList.contains(code)) {
    //   setState(() {
    //     errorCode = 'Already applied this code';
    //     _couponSuccess = null;
    //     _isSubmitLoading = false;
    //   });
    // } else {
    setState(() {
      _isSubmitLoading = true;
    });
    // print('code.toString() -----------' + code.toString());

    // _couponList.add(code);

    // final nextState = await bookAppointmentBloc;
    // print('nextState' + nextState.toString());
    //  final Either<AppError, CouponCodeResult> = bookAppointmentBloc.first;

    // then((result) {
    //   print(result);
    //   if (result != null) {
    //     setState(() {
    //       _couponList.add(result.name);
    //       _isCouponSuccess = 'Coupon code applied successfully!';
    //       _isCouponError = null;
    //       _isSubmitLoading = false;
    //     });
    //   }
    // }).catchError((error) {
    //   print('error in onPressAppy ======>' + error.toString());
    //   setState(() {
    //     _isCouponError = 'Invalid Coupon code';
    //     _isCouponSuccess = null;
    //     _isSubmitLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    double width = assignWidth(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bookAppointmentBloc,
        ),
      ],
      child: BlocListener<BookAppointmentBloc, BookAppointmentState>(
        listener: (context, state) async {
          print('ddd isSubmissionSuccess');

          if (state.status.isSubmissionFailure) {
            SnackBarWidgets.buildErrorSnackbar(context, 'Payment failed');
          }

          if (state.status.isSubmissionSuccess) {
            print('isSubmissionSuccess');
            if (widget.type == "purchagePlan") {
              context
                  .read<BookAppointmentBloc>()
                  .add(PurchageProceedToPayment(widget.pckgitem));
            } else {
              ExtendedNavigator.root.pop();
            }
          }

          print(state.statusCoupon.isSubmissionFailure);
          if (state.statusCoupon.isSubmissionFailure) {
            print('statusCoupon.isSubmissionFailure');
            setState(() {
              // _isCouponSuccess = null;
              _isSubmitLoading = false;
            });
            // SnackBarWidgets.buildErrorSnackbar(context, state.couponError);
          }

          if (state.statusCoupon.isSubmissionSuccess) {
            print('isSubmissionSuccess');
            // SnackBarWidgets.buildErrorSnackbar(
            //     context, 'Coupon code applied successfully!');

            setState(() {
              // _isCouponError = null;
              _couponSuccess = 'Coupon code applied successfully!';
              _isSubmitLoading = false;
            });
            // if (widget.type == "purchagePlan") {
            //   context
            //       .read<BookAppointmentBloc>()
            //       .add(PurchageProceedToPayment(widget.pckgitem));
            // } else {
            //   ExtendedNavigator.root.pop();
            // }
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
            child: CustomAppBar(
                title: StringConst.PAYMENT,
                leading: InkWell(
                    onTap: () => {ExtendedNavigator.root.pop()},
                    child: Icon(Icons.arrow_back_ios_outlined)),
                trailing: [new whatappIconwidget(isHeader: true)],
                hasTrailing: true),
          ),
          body: new ListView(children: [
            Container(
              margin: EdgeInsets.only(
                  top: 40,
                  left: widthOfScreen * 0.04,
                  right: widthOfScreen * 0.04),
              child: BgCardAuto(
                  padding: EdgeInsets.all(0.0),
                  width: widthOfScreen * 0.92,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(Sizes.RADIUS_4),
                  ),
                  child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                      builder: (context, state) {
                    final text = state.couponCode != ''
                        ? state.couponCode.toString()
                        : '';
                    // print('text======${state.date.value.toString()}');
                    var _controller = TextEditingController(
                      text: text ?? "",
                    );
                    if (state.fees != null ||
                        widget.type == "purchagePlan" ||
                        widget.type == "CareCash") {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SpaceH12(),
                            widget.type == "purchagePlan"
                                ? Text(
                                    widget.pckgitem.price != null
                                        ? StringConst.label.PACKAGE_AMOUNT +
                                            ": ${formatCurrency.format(int.parse(widget.pckgitem.price.toString()))}"
                                        : '0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black),
                                    textAlign: TextAlign.start,
                                  )
                                : new Container(),
                            widget.type == "purchagePlan"
                                ? SpaceH16()
                                : new Container(),
                            widget.type == "purchagePlan"
                                ? new Column(
                                    children: [
                                      SummaryItem(
                                        context: context,
                                        label: StringConst.label.PACKAGE,
                                        value: widget.pckgitem.name,
                                      ),
                                      SpaceH8(),
                                      SummaryItem(
                                        context: context,
                                        label: StringConst.label.duration,
                                        value: widget.pckgitem.duration,
                                      ),
                                      SpaceH8(),
                                      SummaryItem(
                                        context: context,
                                        label: StringConst.label.description,
                                        value: widget.pckgitem.description,
                                      )
                                    ],
                                  )
                                : new Container(),
                            widget.type == "CareCash"
                                ? Column(
                                    children: [
                                      if (state.discount != '' &&
                                          state.discount != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: widthOfScreen * 0.60,
                                                child: Text(
                                                  'Discount',
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: widthOfScreen * 0.22,
                                                  child: Text(
                                                    '-' '₹' + state.discount,
                                                    textAlign: TextAlign.right,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                      color: AppColors.green,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      else
                                        new Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: widthOfScreen * 0.60,
                                                child: Text(
                                                  'Amount Payable',
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: widthOfScreen * 0.22,
                                              child: Text(
                                                  (state.discount != null &&
                                                          state.discount != '')
                                                      ? '₹' +
                                                          (int.tryParse(amt) -
                                                                  int.tryParse(state
                                                                      .discount))
                                                              .toString()
                                                      : '₹' + amt.toString(),
                                                  textAlign: TextAlign.right,
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : new Container(),
                            widget.type != "purchagePlan" &&
                                    widget.type != "CareCash"
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: widthOfScreen * 0.60,
                                          child: Text(
                                            widget.type == "bookAppointment"
                                                ? 'Doctor\'s appointment charges'
                                                : 'Service charges',
                                            style: theme.textTheme.bodyText1
                                                .copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: widthOfScreen * 0.22,
                                            child: Text(
                                              widget.type == "purchagePlan"
                                                  ? '₹' +
                                                      widget.pckgitem.price
                                                          .toString()
                                                  : '₹' + state.fees.toString(),
                                              textAlign: TextAlign.right,
                                              style: theme.textTheme.bodyText1
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ))
                                      ],
                                    ),
                                  )
                                : new Container(),
                            widget.type != "purchagePlan" &&
                                    widget.type != "CareCash"
                                ? Column(
                                    children: [
                                      if (state.discount != '' &&
                                          state.discount != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: widthOfScreen * 0.60,
                                                child: Text(
                                                  'Discount',
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: widthOfScreen * 0.22,
                                                  child: Text(
                                                    '-' + '₹' + state.discount,
                                                    textAlign: TextAlign.right,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                      color: AppColors.green,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      else
                                        new Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: widthOfScreen * 0.60,
                                                child: Text(
                                                  'Amount Payable',
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: widthOfScreen * 0.22,
                                              child: Text(
                                                  widget.type == "purchagePlan"
                                                      ? (state.discount != null &&
                                                              state.discount !=
                                                                  '')
                                                          ? '₹' +
                                                              (widget.pckgitem
                                                                          .price -
                                                                      int.tryParse(state
                                                                          .discount))
                                                                  .toString()
                                                          : '₹' +
                                                              widget.pckgitem
                                                                  .price
                                                                  .toString()
                                                      : (state.discount !=
                                                                  null &&
                                                              state.discount !=
                                                                  '')
                                                          ? '₹' +
                                                              (state.fees -
                                                                      int.tryParse(
                                                                          state
                                                                              .discount))
                                                                  .toString()
                                                          : '₹' +
                                                              state.fees
                                                                  .toString(),
                                                  textAlign: TextAlign.right,
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : new Container(),
                            SpaceH16(),
                            BgCard(
                              // padding: EdgeInsets.all(Sizes.PADDING_8),
                              width: width * 0.8,
                              height: 250,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(Sizes.RADIUS_10),
                              ),
                              child: Column(
                                children: [
                                  _CouponCodeInput(),
                                  // BookingTextFormField(
                                  //   controller: _controller,
                                  //   textCapitalization:
                                  //       TextCapitalization.characters,

                                  //   // keyboardType: TextInputType.otp,
                                  //   key: const Key(
                                  //       'appointmentForm_spInput_textField'),
                                  //   hintText: StringConst.sentence.ECC,
                                  //   fieldTitle: StringConst.sentence.ECC,
                                  //   prefixIconHeight: Sizes.ICON_SIZE_18,
                                  //   hasSuffixIcon: true,
                                  //   onChanged: (c) => {
                                  //     setState(() {
                                  //       coupon_code = c;
                                  //     })
                                  //   },
                                  //   errorText: null,
                                  // ),
                                  SpaceH8(),
                                  if (errorCode != null)
                                    Text(
                                      errorCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: AppColors.redShade5,
                                          ),
                                    ),
                                  SpaceH8(),
                                  _isSubmitLoading
                                      ? AppLoading()
                                      : RoundSecondaryButton(
                                          onPressed: () {
                                            if (state.couponCode == '') {
                                              setState(() {
                                                errorCode = 'Enter Coupon Code';
                                              });
                                            } else {
                                              setState(() {
                                                errorCode = null;
                                              });
                                              print('code>>>>' +
                                                  state.couponCode);
                                              onPressApply(state.couponCode);
                                            }
                                          },
                                          title: CommonButtons.APPLY,
                                          theme: theme,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          textColor: AppColors.white,
                                        ),
                                  if (state.couponError != null)
                                    Text(
                                      state.couponError,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: AppColors.redShade5,
                                          ),
                                    ),
                                  if (_couponSuccess != null)
                                    Text(
                                      _couponSuccess,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: AppColors.green,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            SpaceH12(),
                            Container(
                              width: 250,
                              padding: const EdgeInsets.all(8.0),
                              child: PrimaryButton(
                                onPressed: () async {
                                  if (widget.type == "CareCash") {
                                    String amt = await SharedPreferenceHelper
                                        .getCareCashAmountPref();
                                    context
                                        .read<BookAppointmentBloc>()
                                        .add(ProceedToPayment(int.parse(amt)));
                                  } else if (widget.type == "purchagePlan") {
                                    await SharedPreferenceHelper.setPckgeName(
                                        widget.pckgitem.name);
                                    // widget.pckgitem.price
                                    context.read<BookAppointmentBloc>().add(
                                        ProceedToPayment(
                                            widget.pckgitem.price));
                                  } else if (widget.type == "bookAppointment") {
                                    context
                                        .read<BookAppointmentBloc>()
                                        .add(ProceedToPayment(state.fees));
                                  } else {
                                    context
                                        .read<BookAppointmentBloc>()
                                        .add(ProceedToPayment(state.fees));
                                  }
                                },
                                title: StringConst.sentence.Proceed_to_Pay,
                                theme: Theme.of(context),
                              ),
                            ),
                            SpaceH12(),
                            widget.type == "bookAppointment"
                                ? RichText(
                                    text: TextSpan(
                                      text: 'Note: ',
                                      style: theme.textTheme.caption.copyWith(
                                        color: AppColors.black50,
                                        fontWeight: FontWeight.w200,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'A booking amount of INR 1000 will be charged for the specialist appointment. The amount will be added to your CareCash balance and will be adjusted against the invoice after the consultation is done.',
                                          style:
                                              theme.textTheme.caption.copyWith(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w200,
                                            color: AppColors.black50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : new Container(),
                          ],
                        ),
                      );
                    } else
                      return AppLoading();
                  })),
            )
          ]),
        ),
      ),
    );
  }
}

class _CouponCodeInput extends StatefulWidget {
  @override
  __CouponCodeInputState createState() => __CouponCodeInputState();
}

class __CouponCodeInputState extends State<_CouponCodeInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
      buildWhen: (previous, current) =>
          previous.couponCode != current.couponCode,
      builder: (context, state) {
        final text =
            state.couponCode != null ? state.couponCode.toString() : '';
        var _controller = TextEditingController.fromValue(
          TextEditingValue(
            text: text ?? "",
            selection: TextSelection.collapsed(offset: text?.length ?? 0),
          ),
        );
        return BookingTextFormField(
          textCapitalization: TextCapitalization.characters,
          // keyboardType: TextInputType.number,
          key: const Key('appointmentForm_spInput_textField'),
          controller: _controller,
          hintText: StringConst.sentence.ECC,
          fieldTitle: StringConst.sentence.ECC,
          prefixIconHeight: Sizes.ICON_SIZE_18,
          hasSuffixIcon: true,
          onChanged: (c) => {
            context.read<BookAppointmentBloc>().add(
                  CouponChange(c),
                )
          },
          errorText: null,
          // onTap: () async {
          //   FocusScope.of(context).requestFocus(FocusNode());
          //    context.read<BookAppointmentBloc>().add(
          //           CheckCouponValid(),
          //         )
          // }
        );
      },
    );
  }
}
