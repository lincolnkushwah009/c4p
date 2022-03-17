import 'package:care4parents/apple_login/apple_sign_in.dart';
import 'package:care4parents/data/data_sources/appointment_remote_data_source.dart';
import 'package:care4parents/data/data_sources/member_remote_data_source.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/data_sources/subscription_remote_data_source.dart';
import 'package:care4parents/data/data_sources/user_remote_data_source.dart';
import 'package:care4parents/data/repository/appointment_repository_impl.dart';
import 'package:care4parents/data/repository/member_repository_impl.dart';
import 'package:care4parents/data/repository/subscription_repository_impl.dart';
import 'package:care4parents/data/repository/user_repository_impl.dart';
import 'package:care4parents/domain/repositories/appointment_repository.dart';
import 'package:care4parents/domain/repositories/authentication_repository.dart';
import 'package:care4parents/domain/repositories/member_repository.dart';
import 'package:care4parents/domain/repositories/subscription_repository.dart';
import 'package:care4parents/domain/repositories/user_repository.dart';
import 'package:care4parents/domain/usecases/apple.dart';
import 'package:care4parents/domain/usecases/auth.dart';
import 'package:care4parents/domain/usecases/facebookLogin.dart';
import 'package:care4parents/domain/usecases/get_appointments.dart';
import 'package:care4parents/domain/usecases/google.dart';
import 'package:care4parents/domain/usecases/member.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/domain/usecases/user.dart';
// import 'package:care4parents/plugins/facebook/facebook_login.dart';
import 'package:care4parents/presentation/screens/Immunization_list/bloc/immunization_list_bloc.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/bloc/purchagePlan_list_bloc.dart';
import 'package:care4parents/presentation/screens/activity_report/bloc/activity_tab_bloc.dart';
import 'package:care4parents/presentation/screens/appointment_detail/bloc/appointment_detail_bloc.dart';
// import 'package:care4parents/presentation/screens/activity_report/activity_report.dart';
import 'package:care4parents/presentation/screens/appontment/bloc/appointment_tab_bloc.dart';
import 'package:care4parents/presentation/screens/book_appointment/book_appointment.dart';
import 'package:care4parents/presentation/screens/change_password/change_password.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/dashboard.dart';
import 'package:care4parents/presentation/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:care4parents/presentation/screens/edit_profile/bloc/image_picker_bloc.dart';
import 'package:care4parents/presentation/screens/forgot_password/forgot_password.dart';
import 'package:care4parents/presentation/screens/login/bloc/login_bloc.dart';
import 'package:care4parents/presentation/screens/medicine_list/bloc/medicine_list_bloc.dart';
import 'package:care4parents/presentation/screens/member/bloc/member_bloc.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/screens/service/service.dart';
import 'package:care4parents/presentation/screens/settings/bloc/profile_bloc.dart';
import 'package:care4parents/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_add/index.dart';
import 'package:care4parents/presentation/screens/book_service/bloc/book_service_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_flow/bloc/subscription_flow_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_list/subscription_list.dart';
import 'package:care4parents/presentation/screens/upload_report/bloc/upload_report_bloc.dart';
import 'package:care4parents/presentation/screens/welcome/bloc/home_list_bloc.dart';
import 'package:care4parents/util/internet_check.dart';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../data/core/api_client.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<Razorpay>(() => Razorpay());
  getItInstance.registerFactory(() => GoogleSignIn(
      // clientId:
      //     '1095763628136-kl0gi2fk0dapih5rb3pk327qr5vkcs9j.apps.googleusercontent.com',
      // scopes: <String>[
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      ));
  getItInstance.registerFactory(() => FacebookLogin());
  getItInstance.registerFactory(() => AppleSignIn());
  // http client
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // remote data source
  getItInstance.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRempoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<SubscriptionRemoteDataSource>(
      () => SubscriptionRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRempoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<OtherRemoteDataSource>(
      () => OtherRempoteDataSourceImpl(getItInstance()));

  //repository and repository impl
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(
            getItInstance(),
          ));
  getItInstance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        getItInstance(),
      ));

  getItInstance.registerLazySingleton<AppiontmentRepository>(
      () => AppiontmentRepositoryImpl(
            getItInstance(),
          ));
  getItInstance.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(
            getItInstance(),
          ));
  getItInstance
      .registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(
            getItInstance(),
          ));

  getItInstance.registerFactory(() => Connectivity());

  getItInstance
      .registerFactory<InternetCheck>(() => InternetCheck(getItInstance()));

  // usecase

  getItInstance.registerLazySingleton<GoogleSignInUsecase>(() =>
      GoogleSignInUsecase(getItInstance(), getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<FacebookLoginUsercase>(() =>
      FacebookLoginUsercase(
          getItInstance(), getItInstance(), getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppleSigninUsercase>(() =>
      AppleSigninUsercase(
          getItInstance(), getItInstance(), getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<Login>(() => Login(getItInstance()));
  getItInstance.registerLazySingleton<Signup>(() => Signup(getItInstance()));
  getItInstance.registerLazySingleton<ForgotPassword>(
      () => ForgotPassword(getItInstance()));
  getItInstance.registerLazySingleton<GetUser>(() => GetUser(getItInstance()));
  getItInstance
      .registerLazySingleton<EditProfile>(() => EditProfile(getItInstance()));
  getItInstance.registerLazySingleton<ChangePassword>(
      () => ChangePassword(getItInstance()));

  getItInstance.registerLazySingleton<GetUpcomingAppointments>(
      () => GetUpcomingAppointments(getItInstance()));

  getItInstance.registerLazySingleton<GetRequestedAppointments>(
      () => GetRequestedAppointments(getItInstance()));
  getItInstance.registerLazySingleton<CreateAppointment>(
      () => CreateAppointment(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPackage>(() => GetPackage(getItInstance()));
  getItInstance.registerLazySingleton<CreateFamilyMember>(
      () => CreateFamilyMember(getItInstance()));
  getItInstance.registerLazySingleton<CreateFamilyMapping>(
      () => CreateFamilyMapping(getItInstance()));

  getItInstance
      .registerLazySingleton<CreateOrder>(() => CreateOrder(getItInstance()));
  getItInstance.registerLazySingleton<CreateUserPackageMapping>(
      () => CreateUserPackageMapping(getItInstance()));
  getItInstance.registerLazySingleton<UpdateFamilyMember>(
      () => UpdateFamilyMember(getItInstance()));
  getItInstance.registerLazySingleton<MemberServcieMapping>(
      () => MemberServcieMapping(getItInstance()));

  getItInstance.registerLazySingleton<CodeVerification>(
      () => CodeVerification(getItInstance()));

  getItInstance.registerLazySingleton<CodeVerification1>(
      () => CodeVerification1(getItInstance()));
  getItInstance
      .registerLazySingleton<UpdateOrders>(() => UpdateOrders(getItInstance()));
  getItInstance.registerLazySingleton<GetUserFamilyList>(
      () => GetUserFamilyList(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVitalList>(() => GetVitalList(getItInstance()));

  getItInstance.registerLazySingleton<GetVitalLists>(
      () => GetVitalLists(getItInstance()));

  getItInstance.registerLazySingleton<CreateRozerPayOrder>(
      () => CreateRozerPayOrder(getItInstance()));
  //member
  getItInstance.registerLazySingleton<Otp>(() => Otp(getItInstance()));
  getItInstance
      .registerLazySingleton<OtpVerify>(() => OtpVerify(getItInstance()));

  getItInstance.registerLazySingleton<ChangeProfile>(
      () => ChangeProfile(getItInstance()));
  getItInstance
      .registerLazySingleton<EmailVerify>(() => EmailVerify(getItInstance()));

  getItInstance
      .registerLazySingleton<GetServices>(() => GetServices(getItInstance()));
  getItInstance.registerLazySingleton<CreateService>(
      () => CreateService(getItInstance()));

  //bloc
  getItInstance.registerFactory(
    () => LoginBloc(
      login: getItInstance(),
      googleSignInUsecase: getItInstance(),
      facebookLogin: getItInstance(),
      appleSignInUsercase: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SignupBloc(
      signup: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => DrawerBloc(),
  );

  getItInstance.registerFactory(
    () => ForgotPasswordBloc(
      forgotPassword: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => HomeListBloc(
      otherDataSource: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => ProfileBloc(
      getUser: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => EditProfileBloc(
        editProfile: getItInstance(),
        changeProfile: getItInstance(),
        emailVerify: getItInstance()),
  );
  getItInstance.registerFactory(
    () => ChangePasswordBloc(
      changePassword: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => AppointmentTabBloc(
        getUpcomingAppointments: getItInstance(),
        getRequestedAppointments: getItInstance(),
        otherRemoteDataSource: getItInstance()),
  );
  getItInstance.registerFactory(
    () => SubscriptionAddBloc(
      getPackages: getItInstance(),
      createFamilyMember: getItInstance(),
      createFamilyMapping: getItInstance(),
      createOrder: getItInstance(),
      createUserPackageMapping: getItInstance(),
      updateFamilyMember: getItInstance(),
      memberServcieMapping: getItInstance(),
      codeVerification: getItInstance(),
      updateOrders: getItInstance(),
      createRozerPayOrder: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => SubscriptionFlowBloc(
      getPackages: getItInstance(),
      createFamilyMember: getItInstance(),
      createFamilyMapping: getItInstance(),
      createOrder: getItInstance(),
      createUserPackageMapping: getItInstance(),
      updateFamilyMember: getItInstance(),
      memberServcieMapping: getItInstance(),
      codeVerification: getItInstance(),
      updateOrders: getItInstance(),
      createRozerPayOrder: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => DashboardBloc(
      getFamilyList: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MemberBloc(
      phoneSubmit: getItInstance(),
      otpVerify: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => ActivityTabBloc(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => SubscriptionListBloc(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => MedicineListBloc(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => ImmunizationListBloc(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => PurchagePlanListBloc(
      otherDataSource: getItInstance(),
      getPackages: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => OtherCubit(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => AppointmentDetailBloc(
      otherDataSource: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => BookAppointmentBloc(
        createAppointment: getItInstance(),
        otherDataSource: getItInstance(),
        createFamilyMember: getItInstance(),
        createFamilyMapping: getItInstance(),
        createService: getItInstance(),
        createRozerPayOrder: getItInstance(),
        codeVerification: getItInstance()),
  );
  getItInstance.registerFactory(
    () => BookServiceBloc(
      createService: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => ServiceTabBloc(
      getServices: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => ImagePickerBloc(),
  );
  getItInstance.registerFactory(
    () => VitaltypeBloc(
      getVitalList: getItInstance(),
      getVitalLists: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => UploadReportBloc(
      otherRemoteDataSource: getItInstance(),
    ),
  );
}
