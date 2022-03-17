import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/appointment_result_model.dart';
import 'package:care4parents/data/models/common_result.dart';
import 'package:care4parents/data/models/coupon_code_result.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/member_result.dart';
import 'package:care4parents/data/models/object_common_result.dart';
import 'package:care4parents/data/models/page_result.dart';
import 'package:care4parents/data/models/rozar_pay_result.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/appointment_params.dart';
import 'package:care4parents/domain/entities/member_params.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/helper/validation/common.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/PurchageNewMember_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addNewMember_screen.dart';
import 'package:care4parents/presentation/screens/signup/models/models.dart';
import 'package:care4parents/presentation/screens/upload_report/view/upload_screen.dart';
import 'package:care4parents/util/config.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'book_appointment_event.dart';

part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  CreateAppointment createAppointment;
  OtherRemoteDataSource otherDataSource;
  CreateRozerPayOrder createRozerPayOrder;
  final CreateFamilyMember createFamilyMember;
  final CreateFamilyMapping createFamilyMapping;
  final CreateUserPackageMapping createUserPackageMapping;
  // final CodeVerification codeVerification;
  final CodeVerification1 codeVerification;
  CreateService createService;
  Razorpay _razorpay;
  DateFormat dFormat = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  BookAppointmentBloc(
      {@required this.createAppointment,
      @required this.otherDataSource,
      @required this.createRozerPayOrder,
      this.createFamilyMember,
      this.createFamilyMapping,
      this.createService,
      this.createUserPackageMapping,
      this.codeVerification})
      : super(BookAppointmentState()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    on<AppointmentSpecialistChanged>(
      (event, emit) async {
        emit(_mapSpecialistChangedToState(event, state));
      },
      transformer: sequential(),
    );
    on<AppointmentDateChanged>(
      (event, emit) async {
        emit(_mapDateChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<BookAppointmentSubmitted>(
      (event, emit) async {
        await _mapAppointmentSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<AppointmentMemberChanged>(
      (event, emit) async {
        emit(_maMemberChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<AppointmentPhoneChanged>(
      (event, emit) async {
        emit(_maPhoneChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<AppointmentRemarkChanged>(
      (event, emit) async {
        emit(_maRemarkChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<GetPaymentFee>(
      (event, emit) async {
        await _mapGetPaymentFeeToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<ProceedToPayment>(
      (event, emit) async {
        await _mapPaymentToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<NewMemberSubmitted>(
      (event, emit) async {
        await _mapNewMemberSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<ServiceChanged>(
      (event, emit) async {
        emit(_mapServiceChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<ServiceDateChanged>(
      (event, emit) async {
        emit(_mapNewMemDateChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberNameChanged>(
      (event, emit) async {
        emit(_maNameChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberAddressChanged>(
      (event, emit) async {
        emit(_maAddressChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberPhoneChanged>(
      (event, emit) async {
        emit(_manewMemberPhoneChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<BookServiceSubmitted>(
      (event, emit) async {
        await _mapNewMemberBookServiceSubmittedToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<PurchageProceedToPayment>(
      (event, emit) async {
        await _mapPurchagePaymentToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<PurchagePlanMemberSubmitted>(
      (event, emit) async {
        await _mapPurchagePlanMemberToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<NewMemberEmailChanged>(
      (event, emit) async {
        await _manewMemberEmailChangedToState(event, state, emit);
      },
      transformer: sequential(),
    );

    on<NewMemberContactPersonChanged>(
      (event, emit) async {
        emit(_manewMembercontactPersonChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberPincodeChanged>(
      (event, emit) async {
        emit(_manewMemberpincodeChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberStateChanged>(
      (event, emit) async {
        emit(_manewMemberStateChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<NewMemberEmergenncyphoneChanged>(
      (event, emit) async {
        emit(_manewMembernewMemberEmergenncyphoneChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<RelationChanged>(
      (event, emit) async {
        emit(_mapSRelationChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<PurchageNewMemberNameChanged>(
      (event, emit) async {
        emit(_mapPurchageNameChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<PurchageDateChanged>(
      (event, emit) async {
        emit(_mapPurchageNewMemDateChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<PurchageNewMemberPhoneChanged>(
      (event, emit) async {
        emit(_mapPurchagenewMemberPhoneChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<PurchageNewMemberAddressChanged>(
      (event, emit) async {
        emit(_mapPurchageAddressChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<CareCashAmountChanged>(
      (event, emit) async {
        emit(_mapCareCashAmountChangedToState(event, state));
      },
      transformer: sequential(),
    );

    on<CheckCouponValid>(
      (event, emit) async {
        await _mapCheckCouponValidToState(event, state, emit);
      },
      transformer: sequential(),
    );
    on<CouponChange>(
      (event, emit) async {
        emit(_mapChangeCouponToState(event, state));
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<BookAppointmentState> mapEventToState(
  //   BookAppointmentEvent event,
  // ) async* {
  //   if (event is AppointmentSpecialistChanged) {
  //     yield _mapSpecialistChangedToState(event, state);
  //   }else if (event is AppointmentDateChanged) {
  //     yield _mapDateChangedToState(event, state);
  //   } else if (event is BookAppointmentSubmitted) {
  //     yield* _mapAppointmentSubmittedToState(event, state);
  //   } else if (event is AppointmentMemberChanged) {
  //     yield _maMemberChangedToState(event, state);
  //   } else if (event is AppointmentPhoneChanged) {
  //     yield _maPhoneChangedToState(event, state);
  //   } else if (event is AppointmentRemarkChanged) {
  //     yield _maRemarkChangedToState(event, state);
  //   } else if (event is GetPaymentFee) {
  //     yield* _mapGetPaymentFeeToState(event, state);
  //   } else if (event is ProceedToPayment) {
  //     yield* _mapPaymentToState(event, state);
  //   } else if (event is NewMemberSubmitted) {
  //     yield* _mapNewMemberSubmittedToState(event, state);
  //   } else if (event is ServiceChanged) {
  //     yield _mapServiceChangedToState(event, state);
  //   } else if (event is ServiceDateChanged) {
  //     yield _mapNewMemDateChangedToState(event, state);
  //   } else if (event is NewMemberNameChanged) {
  //     yield _maNameChangedToState(event, state);
  //   } else if (event is NewMemberAddressChanged) {
  //     yield _maAddressChangedToState(event, state);
  //   } else if (event is NewMemberPhoneChanged) {
  //     yield _manewMemberPhoneChangedToState(event, state);
  //   } else if (event is BookServiceSubmitted) {
  //     yield* _mapNewMemberBookServiceSubmittedToState(event, state);
  //   } else if (event is PurchageProceedToPayment) {
  //     yield* _mapPurchagePaymentToState(event, state);
  //   } else if (event is PurchagePlanMemberSubmitted) {
  //     yield* _mapPurchagePlanMemberToState(event, state);
  //   } else if (event is NewMemberEmailChanged) {
  //     yield _manewMemberEmailChangedToState(event, state);
  //   } else if (event is NewMemberContactPersonChanged) {
  //     yield _manewMembercontactPersonChangedToState(event, state);
  //   } else if (event is NewMemberPincodeChanged) {
  //     yield _manewMemberpincodeChangedToState(event, state);
  //   } else if (event is NewMemberStateChanged) {
  //     yield _manewMemberStateChangedToState(event, state);
  //   } else if (event is NewMemberEmergenncyphoneChanged) {
  //     yield _manewMembernewMemberEmergenncyphoneChangedToState(event, state);
  //   } else if (event is RelationChanged) {
  //     yield _mapSRelationChangedToState(event, state);
  //   }else if (event is PurchageNewMemberNameChanged) {
  //     yield _mapPurchageNameChangedToState(event, state);
  //   }else if (event is PurchageDateChanged) {
  //     yield _mapPurchageNewMemDateChangedToState(event, state);
  //   }else if (event is PurchageNewMemberPhoneChanged) {
  //     yield _mapPurchagenewMemberPhoneChangedToState(event, state);
  //   }else if (event is PurchageNewMemberAddressChanged) {
  //     yield _mapPurchageAddressChangedToState(event, state);
  //   }else if (event is CareCashAmountChanged) {
  //     yield _mapCareCashAmountChangedToState(event, state);
  //   }else if (event is CheckCouponValid) {
  //    // yield _mapCheckCouponValidToState(event, state);
  //   }

  // }

  BookAppointmentState _mapCareCashAmountChangedToState(
    CareCashAmountChanged event,
    BookAppointmentState state,
  ) {
    final amount = NotEmptyField.dirty(event.amount);
    print('amount>>  ' + event.amount.toString());
    return state.copyWith(
      amount: amount,
      statusCareStatus: Formz.validate([
        amount,
      ]),
    );
  }

  BookAppointmentState _mapChangeCouponToState(
    CouponChange event,
    BookAppointmentState state,
  ) {
    final coupon_code = NotEmptyField.dirty(event.coupon_code);
    print('amount>>  ' + event.coupon_code.toString());
    return state.copyWith(
      couponCode: coupon_code.value,
    );
  }

  BookAppointmentState _mapPurchageAddressChangedToState(
    PurchageNewMemberAddressChanged event,
    BookAppointmentState state,
  ) {
    final address = NotEmptyField.dirty(event.address);
    print('address>>  ' + event.address.toString());
    return state.copyWith(
      address: address,
      statusPurchageTwo: Formz.validate([
        address,
        state.email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        state.state,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _mapPurchagenewMemberPhoneChangedToState(
    PurchageNewMemberPhoneChanged event,
    BookAppointmentState state,
  ) {
    final newMemberphone = PhoneNumber.dirty(event.newMemberphone);
    print('newMemberphone>>  ' + event.newMemberphone.toString());

    return state.copyWith(
      newMemberphone: newMemberphone,
      statusPurchageTwo: Formz.validate([
        state.address,
        state.email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        state.state,
        newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _mapPurchageNewMemDateChangedToState(
    PurchageDateChanged event,
    BookAppointmentState state,
  ) {
    print("sonu>>   _mapNewMemDateChangedToState");
    final date = NotEmptyField.dirty(event.dateMember);
    print("sonu>>   _mapNewMemDateChangedToState>>   " + date.toString());
    return state.copyWith(
      dateMember: date,
      statusPurchageOne: Formz.validate([state.name, date]),
    );
    print("sonu>>   _mapNewMemDateChangedToState");
  }

  BookAppointmentState _mapPurchageNameChangedToState(
    PurchageNewMemberNameChanged event,
    BookAppointmentState state,
  ) {
    final name = NotEmptyField.dirty(event.name);
    print('name>>  ' + event.name.toString());
    return state.copyWith(
      name: name,
      statusPurchageOne: Formz.validate([name, state.dateMember]),
    );
  }

  BookAppointmentState _manewMembernewMemberEmergenncyphoneChangedToState(
    NewMemberEmergenncyphoneChanged event,
    BookAppointmentState statess,
  ) {
    final newMemberEmergenncyphone =
        PhoneNumber.dirty(event.newMemberEmergenncyphone);
    print('newMemberEmergenncyphone>>  ' +
        event.newMemberEmergenncyphone.toString());

    return statess.copyWith(
      newMemberEmergenncyphone: newMemberEmergenncyphone,
      statusPurchageTwo: Formz.validate([
        state.address,
        state.email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        state.state,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _manewMemberStateChangedToState(
    NewMemberStateChanged event,
    BookAppointmentState state,
  ) {
    final states = NotEmptyField.dirty(event.state);
    print('state>>  ' + event.state.toString());

    return state.copyWith(
      state: states,
      statusPurchageTwo: Formz.validate([
        state.address,
        state.email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        states,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _manewMemberpincodeChangedToState(
    NewMemberPincodeChanged event,
    BookAppointmentState state,
  ) {
    final pincode = NotEmptyField.dirty(event.pincode);
    print('pincode>>  ' + event.pincode.toString());

    return state.copyWith(
      pincode: pincode,
      statusPurchageTwo: Formz.validate([
        state.address,
        state.email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        pincode,
        state.state,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _manewMembercontactPersonChangedToState(
    NewMemberContactPersonChanged event,
    BookAppointmentState state,
  ) {
    final contactPerson = NotEmptyField.dirty(event.contactPerson);
    print('contactPerson>>  ' + event.contactPerson.toString());

    return state.copyWith(
      contactPerson: contactPerson,
      statusPurchageTwo: Formz.validate([
        state.address,
        state.email,
        contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        state.state,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    );
  }

  BookAppointmentState _manewMemberEmailChangedToState(
      NewMemberEmailChanged event,
      BookAppointmentState state,
      Emitter<BookAppointmentState> emit) {
    final email = Email.dirty(event.email);
    print('email>>  ' + event.email.toString());

    emit(state.copyWith(
      email: email,
      statusPurchageTwo: Formz.validate([
        state.address,
        email,
        state.contactPerson,
        state.newMemberEmergenncyphone,
        state.pincode,
        state.state,
        state.newMemberphone,
        state.newMemberEmergenncyphone,
      ]),
    ));
  }

  BookAppointmentState _manewMemberPhoneChangedToState(
    NewMemberPhoneChanged event,
    BookAppointmentState state,
  ) {
    final newMemberphone = PhoneNumber.dirty(event.newMemberphone);
    print('newMemberphone>>  ' + event.newMemberphone.toString());

    return state.copyWith(
      newMemberphone: newMemberphone,
      status2: Formz.validate(
          [newMemberphone, state.address, state.name, state.dateMember]),
    );
  }

  BookAppointmentState _maAddressChangedToState(
    NewMemberAddressChanged event,
    BookAppointmentState state,
  ) {
    final address = NotEmptyField.dirty(event.address);
    print('address>>  ' + event.address.toString());
    return state.copyWith(
      address: address,
      status2: Formz.validate(
          [state.newMemberphone, address, state.name, state.dateMember]),
    );
  }

  BookAppointmentState _maNameChangedToState(
    NewMemberNameChanged event,
    BookAppointmentState state,
  ) {
    final name = NotEmptyField.dirty(event.name);
    print('name>>  ' + event.name.toString());
    return state.copyWith(
      name: name,
      status2: Formz.validate(
          [name, state.newMemberphone, state.address, state.dateMember]),
    );
  }

  BookAppointmentState _mapServiceChangedToState(
    ServiceChanged event,
    BookAppointmentState state,
  ) {
    print('event.service.id>>>    ' + event.service.service.toString());

    final service = event.service;

    return state.copyWith(
      service: service,
      status: Formz.validate([state.date]),
    );
  }

  BookAppointmentState _mapSRelationChangedToState(
    RelationChanged event,
    BookAppointmentState state,
  ) {
    print('event.service.id>>>    ' + event.relation.service.toString());

    final service = event.relation;

    return state.copyWith(
      relation: service,
      //  status: Formz.validate([state.date, service]),
    );
  }

  BookAppointmentState _mapNewMemDateChangedToState(
    ServiceDateChanged event,
    BookAppointmentState state,
  ) {
    print("sonu>>   _mapNewMemDateChangedToState");
    final date = NotEmptyField.dirty(event.dateMember);
    print("sonu>>   _mapNewMemDateChangedToState>>   " + date.toString());
    return state.copyWith(
      dateMember: date,
      status2: Formz.validate(
          [state.name, state.newMemberphone, state.address, date]),
    );
    print("sonu>>   _mapNewMemDateChangedToState");
  }

  BookAppointmentState _mapSpecialistChangedToState(
    AppointmentSpecialistChanged event,
    BookAppointmentState state,
  ) {
    final specialist = NotEmptyField.dirty(event.specialist);
    return state.copyWith(
      specialist: specialist,
      status: Formz.validate([state.date, specialist, state.phone]),
    );
  }

  BookAppointmentState _maMemberChangedToState(
    AppointmentMemberChanged event,
    BookAppointmentState state,
  ) {
    final member = event.member;
    print('member >>>>>>>>>>>>>>' + member.toString());
    final phone = PhoneNumber.dirty(member.family_member.phone);
    print(phone);
    return state.copyWith(
      member: member,
      phone: phone,
      status: Formz.validate([state.specialist, state.date]),
    );
  }

  BookAppointmentState _mapDateChangedToState(
    AppointmentDateChanged event,
    BookAppointmentState state,
  ) {
    final date = NotEmptyField.dirty(event.date);

    return state.copyWith(
      date: date,
      status: Formz.validate([state.specialist, date]),
    );
  }

  BookAppointmentState _maPhoneChangedToState(
    AppointmentPhoneChanged event,
    BookAppointmentState state,
  ) {
    final phone = PhoneNumber.dirty(event.phone);

    return state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.specialist,
        state.date,
      ]),
    );
  }

  BookAppointmentState _maRemarkChangedToState(
    AppointmentRemarkChanged event,
    BookAppointmentState state,
  ) {
    final remark = NotEmptyField.dirty(event.remark);
    print('remark>>  ' + event.remark.toString());
    return state.copyWith(
      remark: remark,
    );
  }

  _mapAppointmentSubmittedToState(
    BookAppointmentSubmitted event,
    BookAppointmentState state,
    Emitter<BookAppointmentState> emit,
  ) async {
    print("specialist>> " + state.specialist.value);
    print("date>> " + state.date.value);
    print("phone>> " + state.phone.value);
    print(".status2.isValidated>> " + state.status2.isValidated.toString());
    print(".status1.isValidated>> " + state.status.isValidated.toString());

    print("name>> " + state.name.value);
    //
    print("phonemmm>> " + state.newMemberphone.value);
    print("dateMember>> " + state.dateMember.value);

    print("address>> " + state.address.value);
    print("service>> " + state.service.toString());
    print('dateMember ==========' + state.dateMember.toString());
    if (state.status.isValidated) {
      if (state.member == null && state.memberId == null) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        try {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } on Exception catch (_) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } else {
        if (state.member != null) {
          emit(state.copyWith(status: FormzStatus.submissionInProgress));
        }

        try {
          print("sonu>> " + state.date.value);
          String date = state.date.value.split(" ")[0];
          String time = state.date.value.split(" ")[1];
          String aaa = "";
          int end_time;
          String bbb;
          if (state.date.value.split(" ").length == 3) {
            aaa = state.date.value.split(" ")[2];

            int int_time = int.tryParse(time.split(":")[0]);
            int_time = int_time + 1;
            end_time = int_time > 12 ? int_time - 12 : int_time;
            bbb = int_time <= 12 ? 'AM' : 'PM';
          } else {
            var times = int.tryParse(time.split(":")[0]);

            int in_time = times > 12 ? times - 12 : times;
            aaa = times <= 12 ? 'AM' : 'PM';
            time = in_time.toString() + ":00";

            int int_times = times + 1;
            end_time = int_times > 12 ? int_times - 12 : int_times;
            bbb = int_times <= 12 ? 'AM' : 'PM';
          }

          print('$end_time:00 $bbb');

          final Either<AppError, ObjectCommonResult> eitherResponse =
              await createAppointment(AppointmentParams(
            appointDate: date,
            patientId: state.member == null ? 0 : state.member.family_member.id,
            mobile:
                state.memberId == null ? '' : state.member.family_member.phone,
            phone: state.phone.value,
            speciality: state.specialist.value,
            email: state.member == null ? "" : state.member.family_member.email,
            timerange: '$time $aaa - $end_time:00 $bbb',
            startappointdate: '$date $time $aaa',
            endappointdate: '$date $end_time:00 $bbb',
            remarks: state.remark.value,
            is_add_member: state.member == null ? true : false,
            pincode: "",
            name: state.member == null ? state.name.value : '',
            relation: "",
            gender:
                state.member == null ? state.service.service.toString() : "",
            dob: state.member == null ? state.dateMember.value.toString() : "",
            member_email: "",
            address: state.member == null ? state.address.value : '',
            member_phone:
                state.member == null ? state.newMemberphone.value : "",
            state: "",
          ));

          print('eitherResponse >>>>>>' + eitherResponse.toString());
          emit(eitherResponse.fold(
            (l) {
              print('left error >>>>>');
              return state.copyWith(status: FormzStatus.submissionFailure);
            },
            (r) {
              var d = r.data as Map;
              print('d -------' + d.toString());
              SharedPreferenceHelper.setAppointmentIdPref(d['id']);
              return state.copyWith(status: FormzStatus.submissionSuccess);
            },
          ));
        } on Exception catch (_) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      }
    }
  }

  _mapNewMemberSubmittedToState(NewMemberSubmitted event,
      BookAppointmentState state, Emitter<BookAppointmentState> emit) async {
    print("specialist>> " + state.specialist.value.toString());
    print("date>> " + state.date.value);
    print("phone>> " + state.phone.value);
    print("remark>> " + state.remark.value.toString());

    print("name>> " + state.name.value);
    print("phone>> " + state.newMemberphone.value);
    print("dateMember>> " + state.dateMember.value);
    print("address>> " + state.address.value);
    print("service>> " + state.service.service.toString());
    print("isValidated>> " + state.status2.isValidated.toString());

    if (state.status2.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        User user = await SharedPreferenceHelper.getUserPref();
        print("sonu>> " + state.date.value);
        String date = state.date.value.split(" ")[0];
        String time = state.date.value.split(" ")[1];
        String aaa = "";
        int end_time;
        String bbb;
        if (state.date.value.split(" ").length == 3) {
          aaa = state.date.value.split(" ")[2];

          int int_time = int.tryParse(time.split(":")[0]);
          int_time = int_time + 1;
          end_time = int_time > 12 ? int_time - 12 : int_time;
          bbb = int_time <= 12 ? 'AM' : 'PM';
        } else {
          var times = int.tryParse(time.split(":")[0]);

          int in_time = times > 12 ? times - 12 : times;
          aaa = times <= 12 ? 'AM' : 'PM';
          time = in_time.toString() + ":00";

          int int_times = times + 1;
          end_time = int_times > 12 ? int_times - 12 : int_times;
          bbb = int_times <= 12 ? 'AM' : 'PM';
        }

        print('$end_time:00 $bbb');

        final Either<AppError, ObjectCommonResult> eitherResponse =
            await createAppointment(AppointmentParams(
          appointDate: date,
          patientId: state.member == null ? 0 : state.member.family_member.id,
          mobile:
              state.memberId == null ? '' : state.member.family_member.phone,
          phone: state.phone.value,
          speciality: state.specialist.value,
          email: state.member == null ? "" : state.member.family_member.email,
          timerange: '$time $aaa - $end_time:00 $bbb',
          startappointdate: '$date $time $aaa',
          endappointdate: '$date $end_time:00 $bbb',
          remarks: state.remark.value,
          is_add_member: state.member == null ? true : false,
          pincode: "",
          name: state.member == null ? state.name.value : '',
          relation: "",
          gender: state.member == null ? state.service.service.toString() : "",
          dob: state.member == null ? state.dateMember.value.toString() : "",
          member_email: "",
          address: state.member == null ? state.address.value : '',
          member_phone: state.member == null ? state.newMemberphone.value : "",
          state: "",
          emergency_contact_person: user.name,
          emergency_country_code: "",
          emergency_contact_no: user.phone_number,
        ));

        print('eitherResponse >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error >>>>>');
            return state.copyWith(status: FormzStatus.submissionFailure);
          },
          (r) {
            var d = r.data as Map;
            print('d -------' + d.toString());
            SharedPreferenceHelper.setAppointmentIdPref(d['id']);
            return state.copyWith(status: FormzStatus.submissionSuccess);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else {
      // yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

  _mapNewMemberBookServiceSubmittedToState(BookServiceSubmitted event,
      BookAppointmentState state, Emitter<BookAppointmentState> emit) async {
    print("  bookService_idspecialist>> " + state.specialist.value.toString());
    print("bookService_iddate>> " + state.date.value);
    print("bookService_idphone>> " + state.phone.value);
    print("bookService_idremark>> " + state.remark.value.toString());

    print("bookService_idname>> " + state.name.value);
    print("phone>> " + state.newMemberphone.value);
    print("bookService_iddateMember>> " + state.dateMember.value);
    print("address>> " + state.address.value);
    print("bookService_idservice>> " + state.service.service.toString());
    print(
        " bookService_idisValidated>> " + state.status2.isValidated.toString());

    if (state.status2.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        User user = await SharedPreferenceHelper.getUserPref();
        print("sonu>> " + state.date.value);
        String date = state.date.value.split(" ")[0];
        String time = state.date.value.split(" ")[1];
        String aaa = "";
        int end_time;
        String bbb;
        if (state.date.value.split(" ").length == 3) {
          aaa = state.date.value.split(" ")[2];

          int int_time = int.tryParse(time.split(":")[0]);
          int_time = int_time + 1;
          end_time = int_time > 12 ? int_time - 12 : int_time;
          bbb = int_time <= 12 ? 'AM' : 'PM';
        } else {
          var times = int.tryParse(time.split(":")[0]);

          int in_time = times > 12 ? times - 12 : times;
          aaa = times <= 12 ? 'AM' : 'PM';
          time = in_time.toString() + ":00";

          int int_times = times + 1;
          end_time = int_times > 12 ? int_times - 12 : int_times;
          bbb = int_times <= 12 ? 'AM' : 'PM';
        }

        print('$end_time:00 $bbb');
        await SharedPreferenceHelper.setBookServiceName(
            state.specialist.value.toString());
        String getBookServiceName =
            await SharedPreferenceHelper.getBookServiceName();
        print("getBookServiceName>>  " + getBookServiceName);
        final Either<AppError, ObjectCommonResult> eitherResponse =
            await createService(ServiceParams(
          bookingdate: date,
          service: state.specialist.value,
          startbookingdate: '$date $time $aaa',
          endbookingdate: '$date $end_time:00 $bbb',
          patientId: state.member == null ? 0 : state.member.family_member.id,
          mobile:
              state.memberId == null ? '' : state.member.family_member.phone,
          phone: state.phone.value,
          email: state.member == null ? "" : state.member.family_member.email,
          timerange: '$time $aaa - $end_time:00 $bbb',
          remarks: state.remark.value,
          is_add_member: state.member == null ? true : false,
          pincode: "",
          name: state.member == null ? state.name.value : '',
          relation: "",
          gender: state.member == null ? state.service.service.toString() : "",
          dob: state.member == null ? state.dateMember.value.toString() : "",
          member_email: "",
          address: state.member == null ? state.address.value : '',
          member_phone: state.member == null ? state.newMemberphone.value : "",
          state: "",
          emergency_contact_person: user.name,
          emergency_country_code: "",
          emergency_contact_no: user.phone_number,
        ));

        print('eitherResponse >>>>>>' + eitherResponse.toString());
        emit(eitherResponse.fold(
          (l) {
            print('left error >>>>>');
            return state.copyWith(status: FormzStatus.submissionFailure);
          },
          (r) {
            var d = r.data as Map;
            print('d -------' + d.toString());
            SharedPreferenceHelper.setBookServiceIdPref(d['id']);
            return state.copyWith(status: FormzStatus.submissionSuccess);
          },
        ));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else {
      // yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

  _mapGetPaymentFeeToState(GetPaymentFee event, BookAppointmentState state,
      Emitter<BookAppointmentState> emit) async {
    try {
      final Either<AppError, int> eitherResponse =
          await otherDataSource.getPaymentFees(event.appointment_id);

      print('eitherResponse >>>>>>' + eitherResponse.toString());
      emit(eitherResponse.fold(
        (l) {
          print('left error >>>>>');
          return state.copyWith(status: FormzStatus.submissionFailure);
        },
        (r) {
          return state.copyWith(fees: r);
        },
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  _mapPurchagePaymentToState(PurchageProceedToPayment event,
      BookAppointmentState state, Emitter<BookAppointmentState> emit) async {
    try {
      int duration = int.parse(event.pckgitem.duration.split(' ')[0]);
      final DateTime today = new DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateTime after_date =
          new DateTime(today.year, today.month + duration, today.day);
      final String start_date = formatter.format(today);
      final String end_date = formatter.format(after_date);
      print('end_date' + end_date.toString());
      print('start_date' + start_date.toString());
      User user = await SharedPreferenceHelper.getUserPref();
      final Either<AppError, ObjectCommonResult> eitherROrder =
          await otherDataSource.purchagePlanPayment(
              PuechagePackageMappingParams(
                  package_id: event.pckgitem.id.toString(),
                  start_date: start_date,
                  end_time: end_date,
                  package_code: event.pckgitem.code,
                  quantity: 1,
                  user_id: user.id.toString(),
                  order_datetime: formatter.format(today),
                  status: 'PAID',
                  amount: event.pckgitem.price.toString(),
                  payment_id: "",
                  payment_type: "--"));
      eitherROrder.fold((l) {
        print('left error purchagePlanPayment>>>>>' + l.toString());
      }, (r_order) async {
        print('right error purchagePlanPayment>>>>>' + r_order.toString());

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        // await openCheckout(r_order.id, event.amount);
      });
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  _mapPaymentToState(ProceedToPayment event, BookAppointmentState state,
      Emitter<BookAppointmentState> emit) async {
    try {
      int appointment_id = await SharedPreferenceHelper.getAppointmentIdPref();
      int bookService_id = await SharedPreferenceHelper.getBookServiceIdPref();
      String patient_id =
          await SharedPreferenceHelper.getCareCashpatientIdPref();
      String getBookServiceName =
          await SharedPreferenceHelper.getBookServiceName();
      String getPckgeName = await SharedPreferenceHelper.getPckgeName();
      print("getBookServiceName" + getBookServiceName);
      final Either<AppError, RozarPayResult> eitherROrder =
          await createRozerPayOrder(event.amount);
      eitherROrder.fold((l) {
        print('left error createOrder Rozarpay>>>>>' + l.toString());
      }, (r_order) async {
        print('right error createOrder Rozarpay>>>>>' + r_order.toString());

        String rozorpayDes;
        if (appointment_id != null) {
          rozorpayDes = CONFIG.ROZAR_PAY_DESC_BUY_SERVICE;
        } else if (bookService_id != null) {
          rozorpayDes = getBookServiceName;
        } else if (patient_id != null) {
          rozorpayDes = CONFIG.ROZAR_PAY_Member_Care_Cash;
        } else {
          rozorpayDes = getPckgeName;
        }

        await openCheckout(r_order.id, event.amount, rozorpayDes);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        // await SharedPreferenceHelper.setPurchageRozorPayRESPref(
        //     RozorPayMappingParams(
        //         razorpay_payment_id: "response.paymentId",
        //             orderId: "response.orderId",
        //             signature: "response.signature")
        //        );

        // await _PurchagePaymentToState(RozorPayMappingParams(
        //     paymentId: "response.paymentId",
        //     orderId: "response.orderId",
        //     signature: "response.signature"));

        // await _addCareCashPaymentToState(RozorPayMappingParams(
        //     paymentId: "response.paymentId",
        //     orderId: "response.orderId",
        //     signature: "response.signature"));
      });
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void openCheckout(order_id, amount, description) async {
    print("description>>   " + description.toString());

    User user_data = await SharedPreferenceHelper.getUserPref();
    var options = {
      'key': CONFIG.ROZAR_PAY_KEY,
      'order_id': order_id,
      'amount': amount * 100,
      // 'amount': 1 * 100,
      "name": CONFIG.ROZAR_PAY_NAME,
      "description": description.toString(),
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded" + response.toString());
    print("SUCCESS: paymentId >" + response.paymentId); //pay_Gs0KZzJFqUOJ4J
    print("SUCCESS: orderId >" + response.orderId);
    if (response.orderId != null) {
      int appointment_id = await SharedPreferenceHelper.getAppointmentIdPref();
      int bookService_id = await SharedPreferenceHelper.getBookServiceIdPref();
      String patient_id =
          await SharedPreferenceHelper.getCareCashpatientIdPref();

      print("SUCCESS: appointment_id >" + appointment_id.toString());
      print("SUCCESS: bookService_id >" + bookService_id.toString());
      if (appointment_id != null || bookService_id != null) {
        final Either<AppError, PResult> updateOrder =
            await otherDataSource.updatePayment(RozorPayMappingParams(
                razorpay_payment_id: response.paymentId,
                orderId: response.orderId,
                signature: response.signature));
        updateOrder.fold((l) {
          print('left error updateOrders>>>>>' + l.toString());
        }, (orderResult) async {
          print('orderResult -------');
          await SharedPreferenceHelper.setAppointmentIdPref(null);
          await SharedPreferenceHelper.setAppointmentIdPref(null);
          ExtendedNavigator.root.pushAndRemoveUntil(
            Routes.HomeTypeScreen,
            (route) => false,
          );
          return state.copyWith(status: FormzStatus.submissionSuccess);
        });
      } else if (patient_id != null) {
        await _addCareCashPaymentToState(RozorPayMappingParams(
            razorpay_payment_id: response.paymentId,
            orderId: response.orderId,
            signature: response.signature));
      } else {
        print('left response response Rozarpay>>>>>' + response.toString());
        //return state.copyWith(status: FormzStatus.submissionSuccess);

        await SharedPreferenceHelper.setPurchageRozorPayRESPref(
            RozorPayMappingParams(
                razorpay_payment_id: response.paymentId,
                orderId: response.orderId,
                signature: response.signature));

        await _PurchagePaymentToState(RozorPayMappingParams(
            razorpay_payment_id: response.paymentId,
            orderId: response.orderId,
            signature: response.signature));
      }
    }

    _razorpay.clear();
    // ExtendedNavigator.root.popUntil((route) => false);

    // Do something when payment succeeds
  }

  void _addCareCashPaymentToState(
      RozorPayMappingParams rozorPayMappingParams) async {
    try {
      String amt = await SharedPreferenceHelper.getCareCashAmountPref();
      String patient = await SharedPreferenceHelper.getCareCashpatientIdPref();
      String reason = await SharedPreferenceHelper.getCareCashreasonPref();

      final Either<AppError, ObjectCommonResult> eitherROrder =
          await otherDataSource.addCareCashPayment(AddCareCashMappingParams(
        patientId: patient.toString(),
        reason: reason.toString(),
        amount: amt.toString(),
        razorpay_response: rozorPayMappingParams,
      ));
      eitherROrder.fold((l) {
        print('left error createOrder Rozarpay>>>>>' + l.toString());
      }, (r_order) async {
        print('right error createOrder finallllll>>>>>' + r_order.toString());
        List<FamilyMainResult> members =
            await SharedPreferenceHelper.getFamilyMermbersPref();
        final index = members.indexWhere((element) =>
            element.family_member_id == int.parse(patient.toString()));
        if (index >= 0) {
          print('Using indexWhere: ${members[index]}');
        }
        // ExtendedNavigator.root
        //     .push(
        //   Routes.memberProfileScreen,
        //   arguments: MemberProfileScreenArguments(member: members[0]),
        // );

        Fluttertoast.showToast(
            msg: "Carecash added successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[200],
            textColor: Colors.black,
            fontSize: 16.0);
        ExtendedNavigator.root.pushAndRemoveUntil(
          Routes.memberProfileScreen,
          ModalRoute.withName('/user_type_screen'),
          arguments: MemberProfileScreenArguments(
              member: members[index], carecashAmt: amt),
        );

        state.copyWith(status: FormzStatus.submissionSuccess);
      });
    } on Exception catch (e) {
      print("Encountered error:" + e.toString());
    }
  }

  void _PurchagePaymentToState(
      RozorPayMappingParams rozorPayMappingParams) async {
    Package packageItem = await SharedPreferenceHelper.getPackagePref();
    try {
      int duration = int.parse(packageItem.duration.split(' ')[0]);
      final DateTime today = new DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateTime after_date =
          new DateTime(today.year, today.month + duration, today.day);
      final String start_date = formatter.format(today);
      final String end_date = formatter.format(after_date);
      print('end_date' + end_date.toString());
      print('start_date' + start_date.toString());
      User user = await SharedPreferenceHelper.getUserPref();
      final Either<AppError, ObjectCommonResult> eitherROrder =
          await otherDataSource.purchagePlanPayment(
              PuechagePackageMappingParams(
                  package_id: packageItem.id.toString(),
                  start_date: start_date,
                  end_time: end_date,
                  package_code: packageItem.code,
                  quantity: 1,
                  user_id: user.id.toString(),
                  order_datetime: formatter.format(DateTime.now()),
                  status: 'PAID',
                  amount: packageItem.price.toString(),
                  payment_id: rozorPayMappingParams.toJson().toString(),
                  razorpay_response: rozorPayMappingParams,
                  payment_type: "PG"));
      eitherROrder.fold((l) {
        print('left error createOrder Rozarpay>>>>>' + l.toString());
      }, (r_order) async {
        PaymentRes paymentRes = PaymentRes.fromJson(r_order.data);
        print('right error createOrder finallllll>>>>>' +
            r_order.data.toString());
        print('right error createOrder finallllll idid>>>>>' +
            paymentRes.id.toString());
        await SharedPreferenceHelper.setPurchagePaymentIdPref(paymentRes.id);
        ExtendedNavigator.root.pop();
        ExtendedNavigator.root.pop();
        ExtendedNavigator.root.push(Routes.PurchageNewMember,
            arguments: PurchageNewMemberArguments(type: 'purchagePlan'));
        state.copyWith(status: FormzStatus.submissionSuccess);
      });
    } on Exception catch (e) {
      print("Encountered error:" + e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    // ExtendedNavigator.root.pop((route) => true);
    state.copyWith(status: FormzStatus.submissionFailure);
    _razorpay.clear();
    ;
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    state.copyWith(status: FormzStatus.submissionFailure);

    // Do something when an external wallet is selected
  }

  _mapPurchagePlanMemberToState(
    PurchagePlanMemberSubmitted event,
    BookAppointmentState state,
    Emitter<BookAppointmentState> emit,
  ) async {
    Package packageItem = await SharedPreferenceHelper.getPackagePref();
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      int duration = int.parse(packageItem.duration.split(' ')[0]);
      final DateTime today = new DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final DateTime after_date =
          new DateTime(today.year, today.month + duration, today.day);
      final String start_date = formatter.format(today);
      final String end_date = formatter.format(after_date);
      print('end_date' + end_date.toString());
      print('start_date' + start_date.toString());
      User user = await SharedPreferenceHelper.getUserPref();
      int purchagePaymentId =
          await SharedPreferenceHelper.getPurchagePaymentIdPref();
      RozorPayMappingParams rozorPayMappingParams =
          await SharedPreferenceHelper.getPurchageRozorPayRESPref();
      final Either<AppError, ObjectCommonResult> eitherROrder =
          await otherDataSource
              .purchagePlanNewMemberSubmit(PuechageNewMemberMappingParams(
        package_id: packageItem.id.toString(),
        start_date: start_date,
        end_time: end_date,
        package_code: packageItem.code,
        quantity: 1,
        user_id: user.id.toString(),
        order_datetime: formatter.format(DateTime.now()),
        status: 'PAID',
        amount: packageItem.price.toString(),
        payment_id: "payment_id",
        payment_type: "PG",
        // id: purchagePaymentId.toString(),
        razorpay_response: rozorPayMappingParams,
        pincode: state.pincode.value.toString(),
        name: state.member == null ? state.name.value : '',
        relation: state.relation.service.toString(),
        gender: state.member == null ? state.service.service.toString() : "",
        dob: state.member == null ? state.dateMember.value.toString() : "",
        member_email: state.email.value.toString(),
        address: state.member == null ? state.address.value : '',
        member_phone: state.member == null ? state.newMemberphone.value : "",
        state: state.state.value.toString(),
        emergency_contact_person: state.contactPerson.value != ""
            ? state.contactPerson.value
            : user.name,
        emergency_country_code: "",
        emergency_contact_no: state.newMemberEmergenncyphone.value != ""
            ? state.newMemberEmergenncyphone.value
            : user.phone_number,
      ));
      eitherROrder.fold((l) {
        print('left error purchagePlanNewMemberSubmit>>>>>' + l.toString());
        return state.copyWith(status: FormzStatus.submissionFailure);
      }, (r_order) {
        print('right error purchagePlanNewMemberSubmit>>>>>' +
            r_order.toString());

        ExtendedNavigator.root.pushAndRemoveUntil(
          Routes.HomeTypeScreen,
          (route) => false,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        // await openCheckout(r_order.id, event.amount);
      });
    } on Exception catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  _mapCheckCouponValidToState(
    CheckCouponValid event,
    BookAppointmentState state,
    Emitter<BookAppointmentState> emit,
  ) async {
    try {
      final Either<AppError, CouponCodeResult> eitherResponse =
          await codeVerification(CouponCodeParams1(
        code: event.coupon_code.toString(),
        package_id: event.pkgItem,
        amount: event.amount != null
            ? event.amount
            : int.parse(state.fees.toString()),
      ));
      emit(eitherResponse.fold((l) {
        print('left error checkCouponValid 1>>>>>' + l.message);

        return state.copyWith(
            statusCoupon: FormzStatus.submissionFailure,
            couponError: l.message);
      }, (r) {
        if (r.status == true) {
          print('right success checkCouponValid 1>>>>>' +
              r.toString() +
              state.fees.toString() +
              r.amount.toString());
          var discount;
          if (r.amount > 0) {
            discount = r.amount;
          }

          return state.copyWith(
            statusCoupon: FormzStatus.submissionSuccess,
            couponCode: '',
            couponError: '',
            discount: discount.toString(),
          );
        } else {
          print('right error checkCouponValid 1>>>>>' + r.toString());

          return state.copyWith(
            statusCoupon: FormzStatus.submissionFailure,
            couponCode: '',
            couponError: 'Unknowed Error',
          );
        }
      }));
    } on Exception catch (error) {
      print('Exception >>>>>>' + error.toString());
      return null;
    }
  }
}
