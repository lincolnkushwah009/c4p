// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/PurchageAccountNewMember_screen.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/PurchageNewMember_screen.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/purchagePlan_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addCareCash_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addNewMember_screen.dart';
import 'package:care4parents/presentation/screens/subscription_flow/view/subscription_flow_screen.dart';
import 'package:care4parents/presentation/screens/welcome/after_login_type_screen.dart';
import 'package:care4parents/presentation/widgets/pdfviewer.dart';
import 'package:flutter/material.dart';

import '../../data/models/appointment_model.dart';
import '../../data/models/family_main_result.dart';
import '../../data/models/report_detail.dart';
import '../../domain/entities/user_entity.dart';
import '../screens/Immunization_list/view/immunization_screen.dart';
import '../screens/activity_report/activity_report.dart';
import '../screens/appointment_detail/appointment_detail_screen.dart';
import '../screens/appontment/appointment.dart';
import '../screens/book_appointment/book_appointment.dart';
import '../screens/book_appointment/view/date_time.dart';
import '../screens/book_appointment/view/payment_screen.dart';
import '../screens/book_appointment/view/search_specialist.dart';
import '../screens/book_service/book_service.dart';
import '../screens/book_service/view/search_member.dart';
import '../screens/book_service/view/search_specialist.dart';
import '../screens/change_password/change_password.dart';
import '../screens/edit_profile/profile.dart';
import '../screens/forgot_password/forgot_password.dart';
import '../screens/home/home.dart';
import '../screens/home_dashboard/view/home_dashboard_screen.dart';
import '../screens/login/login.dart';
import '../screens/medicine_list/view/medicine_screen.dart';
import '../screens/member/member.dart';
import '../screens/member_profile/member_profile.dart';
import '../screens/my_family/view/my_family_screen.dart';
import '../screens/onboading/on_boading_screen.dart';
import '../screens/other/cubit/other_cubit.dart';
import '../screens/other/view/faq_screen.dart';
import '../screens/other/view/privacy_screen.dart';
import '../screens/other/view/tearm_screen.dart';
import '../screens/otp/otp.dart';
import '../screens/record_vital/model/record.dart';
import '../screens/record_vital/view/ecg_screen.dart';
import '../screens/record_vital/view/record_view.dart';
import '../screens/record_vital/view/record_vital_screen.dart';
import '../screens/record_vital/view/single_record_vital.dart';
import '../screens/record_vital/view/view_past.dart';
import '../screens/report_detail/view/report_detail_screen.dart';
import '../screens/report_detail/view/trend_report.dart';
import '../screens/service/service.dart';
import '../screens/settings/settings.dart';
import '../screens/signup/signup.dart';
import '../screens/splash_screen.dart';
import '../screens/subscription_add/index.dart';
import '../screens/subscription_list/view/subscription_screen.dart';
import '../screens/upload_report/view/upload_screen.dart';
import '../screens/welcome/user_type_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import 'auth_guard.dart';

class Routes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String welcomeScreen = '/welcome-screen';
  static const String HomeTypeScreen = '/user_type_screen';
  static const String PdfViewer = '/PdfViewer';
  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
  static const String userTypeScreen = '/user-type-screen';
  static const String otpScreen = '/otp-screen';
  static const String homeScreen = '/home-screen';
  static const String appointmentScreen = '/appointment-screen';
  static const String bookAppointmentScreen = '/book-appointment-screen';
  static const String serviceScreen = '/service-screen';
  static const String bookServiceScreen = '/book-service-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String settingScreen = '/setting-screen';
  static const String profileScreen = '/profile-screen';
  static const String changePasswordScreen = '/change-password-screen';
  static const String subscriptionListScreen = '/subscription-list-screen';
  static const String subscriptionAddScreen = '/subscription-add-screen';
  static const String subscriptionFlowScreen = '/subscription-flow-screen';
  static const String homeDashboardScreen = '/home-dashboard-screen';
  static const String memberProfileScreen = '/member-profile-screen';
  static const String memberMobileScreen = '/member-mobile-screen';
  static const String memberOtpScreen = '/member-otp-screen';
  static const String activityReportScreen = '/activity-report-screen';
  static const String privacyScreen = '/privacy-screen';
  static const String tearmsScreen = '/tearms-screen';
  static const String faqScreen = '/faq-screen';
  static const String searchScreen = '/search-screen';
  static const String searchServiceScreen = '/search-service-screen';
  static const String calenderScreen = '/calender-screen';
  static const String recordVitalScreen = '/record-vital-screen';
  static const String singleRecordVital = '/single-record-vital';
  static const String familyListScreen = '/family-list-screen';
  static const String medicineListScreen = '/medicine-list-screen';
  static const String immunizationListScreen = '/immunization-list-screen';
  static const String appointmentDetailScreen = '/appointment-detail-screen';
  static const String recordView = '/record-view';
  static const String viewPastScreen = '/view-past-screen';
  static const String ecgScreen = '/ecg-screen';
  static const String searchMemberScreen = '/search-member-screen';
  static const String uploadScreen = '/upload-screen';
  static const String reportDetailScreen = '/report-detail-screen';
  static const String trendReport = '/trend-report';
  static const String appointmentPayment = '/appointment-payment';
  static const String addNewMemberScreen = '/addNewMember-screen';
  static const String addNewMemberBookService = '/addNewMemberService-screen';
  static const String purchagePlanListScreen = '/purchagePlanListScreen-screen';
  static const String PurchageNewMember = '/PurchageNewMember-screen';
  static const String purchageAccountNewMember = '/PurchageAccountNewMember-screen';
  static const String addCareCashScreen = '/addCareCashScreen-screen';



  static const all = <String>{
    splashScreen,
    onBoardingScreen,
    welcomeScreen,
    HomeTypeScreen,
    PdfViewer,
    loginScreen,
    signupScreen,
    userTypeScreen,
    otpScreen,
    homeScreen,
    appointmentScreen,
    bookAppointmentScreen,
    serviceScreen,
    bookServiceScreen,
    forgotPasswordScreen,
    settingScreen,
    profileScreen,
    changePasswordScreen,
    subscriptionListScreen,
    subscriptionAddScreen,
    subscriptionFlowScreen,

    homeDashboardScreen,
    memberProfileScreen,
    memberMobileScreen,
    memberOtpScreen,
    activityReportScreen,
    privacyScreen,
    tearmsScreen,
    faqScreen,
    searchScreen,
    searchServiceScreen,
    calenderScreen,
    recordVitalScreen,
    singleRecordVital,
    familyListScreen,
    medicineListScreen,
    immunizationListScreen,
    appointmentDetailScreen,
    recordView,
    viewPastScreen,
    ecgScreen,
    searchMemberScreen,
    uploadScreen,
    reportDetailScreen,
    trendReport,
    appointmentPayment,
    addNewMemberScreen,
    addNewMemberBookService,
    purchagePlanListScreen,PurchageNewMember,
    purchageAccountNewMember,addCareCashScreen
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.onBoardingScreen, page: OnBoardingScreen),
    RouteDef(Routes.welcomeScreen, page: WelcomeScreen),
    RouteDef(Routes.HomeTypeScreen, page: LginTypeScreen),
    RouteDef(Routes.PdfViewer, page: PdfViewer),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.signupScreen, page: SignupScreen),
    RouteDef(Routes.userTypeScreen, page: UserTypeScreen),
    RouteDef(Routes.otpScreen, page: OtpScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen, guards: [AuthGuard]),
    RouteDef(Routes.appointmentScreen,
        page: AppointmentScreen, guards: [AuthGuard]),
    RouteDef(Routes.bookAppointmentScreen,
        page: BookAppointmentScreen, guards: [AuthGuard]),
    RouteDef(Routes.addCareCashScreen,
        page: AddCareCashScreen, guards: [AuthGuard]),


    RouteDef(Routes.serviceScreen, page: ServiceScreen, guards: [AuthGuard]),
    RouteDef(Routes.bookServiceScreen,
        page: BookServiceScreen, guards: [AuthGuard]),
    RouteDef(Routes.forgotPasswordScreen, page: ForgotPasswordScreen),
    RouteDef(Routes.settingScreen, page: SettingScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.changePasswordScreen, page: ChangePasswordScreen),
    RouteDef(Routes.subscriptionListScreen, page: SubscriptionListScreen),
    RouteDef(Routes.subscriptionAddScreen, page: SubscriptionAddScreen),
    RouteDef(Routes.subscriptionFlowScreen, page: SubscriptionFlowScreen),
    RouteDef(Routes.homeDashboardScreen, page: HomeDashboardScreen),
    RouteDef(Routes.memberProfileScreen, page: MemberProfileScreen),
    RouteDef(Routes.memberMobileScreen, page: MemberMobileScreen),
    RouteDef(Routes.memberOtpScreen, page: MemberOtpScreen),
    RouteDef(Routes.activityReportScreen, page: ActivityReportScreen),
    RouteDef(Routes.privacyScreen, page: PrivacyScreen),
    RouteDef(Routes.tearmsScreen, page: TearmsScreen),
    RouteDef(Routes.faqScreen, page: FaqScreen),
    RouteDef(Routes.searchScreen, page: SearchScreen),
    RouteDef(Routes.searchServiceScreen, page: SearchServiceScreen),
    RouteDef(Routes.calenderScreen, page: CalenderScreen),
    RouteDef(Routes.recordVitalScreen, page: RecordVitalScreen),
    RouteDef(Routes.singleRecordVital, page: SingleRecordVital),
    RouteDef(Routes.familyListScreen, page: FamilyListScreen),
    RouteDef(Routes.medicineListScreen, page: MedicineListScreen),
    RouteDef(Routes.immunizationListScreen, page: ImmunizationListScreen),
    RouteDef(Routes.appointmentDetailScreen, page: AppointmentDetailScreen),
    RouteDef(Routes.recordView, page: RecordView),
    RouteDef(Routes.viewPastScreen, page: ViewPastScreen),
    RouteDef(Routes.ecgScreen, page: EcgScreen),
    RouteDef(Routes.searchMemberScreen, page: SearchMemberScreen),
    RouteDef(Routes.uploadScreen, page: UploadScreen),
    RouteDef(Routes.reportDetailScreen, page: ReportDetailScreen),
    RouteDef(Routes.trendReport, page: TrendReport),
    RouteDef(Routes.appointmentPayment, page: AppointmentPayment),
    RouteDef(Routes.addNewMemberScreen, page: AddNewMember),
    // RouteDef(Routes.addNewMemberBookService, page: AddNewMemberBookService),
    RouteDef(Routes.purchagePlanListScreen, page: PurchagePlanListScreen),
    RouteDef(Routes.PurchageNewMember, page: PurchageNewMember),
    RouteDef(Routes.purchageAccountNewMember, page: PurchageAccountNewMember),

  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
    WelcomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const WelcomeScreen(),
        settings: data,
      );
    },
    LginTypeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) =>  LginTypeScreen(),
        settings: data,
      );
    },
    PdfViewer: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) =>  PdfViewer(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    SignupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupScreen(),
        settings: data,
      );
    },
    UserTypeScreen: (data) {
      final args = data.getArgs<UserTypeScreenArguments>(
        orElse: () => UserTypeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserTypeScreen(
          key: args.key,
          banners: args.banners,
        ),
        settings: data,
      );
    },
    OtpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OtpScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      final args = data.getArgs<HomeScreenArguments>(
        orElse: () => HomeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(tab: args.tab),
        settings: data,
      );
    },
    AppointmentScreen: (data) {
      final args = data.getArgs<AppointmentScreenArguments>(
        orElse: () => AppointmentScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppointmentScreen(key: args.key),
        settings: data,
      );
    },
    BookAppointmentScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BookAppointmentScreen(),
        settings: data,
      );
    },

    AddCareCashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddCareCashScreen(),
        settings: data,
      );
    },
    ServiceScreen: (data) {
      final args = data.getArgs<ServiceScreenArguments>(
        orElse: () => ServiceScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ServiceScreen(key: args.key),
        settings: data,
      );
    },
    BookServiceScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BookServiceScreen(),
        settings: data,
      );
    },
    ForgotPasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordScreen(),
        settings: data,
      );
    },
    SettingScreen: (data) {
      final args = data.getArgs<SettingScreenArguments>(
        orElse: () => SettingScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingScreen(key: args.key),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      final args = data.getArgs<ProfileScreenArguments>(
        orElse: () => ProfileScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(user: args.user),
        settings: data,
      );
    },
    ChangePasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePasswordScreen(),
        settings: data,
      );
    },
    SubscriptionListScreen: (data) {
      final args = data.getArgs<SubscriptionListScreenArguments>(
        orElse: () => SubscriptionListScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubscriptionListScreen(key: args.key),
        settings: data,
      );
    },
    SubscriptionAddScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubscriptionAddScreen(),
        settings: data,
      );
    },

    SubscriptionFlowScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubscriptionFlowScreen(),
        settings: data,
      );
    },
    HomeDashboardScreen: (data) {
      final args = data.getArgs<HomeDashboardScreenArguments>(
        orElse: () => HomeDashboardScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeDashboardScreen(tab: args.tab),
        settings: data,
      );
    },
    MemberProfileScreen: (data) {
      final args = data.getArgs<MemberProfileScreenArguments>(
        orElse: () => MemberProfileScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberProfileScreen(member: args.member,carecashAmt:args.carecashAmt),
        settings: data,
      );
    },
    MemberMobileScreen: (data) {
      final args = data.getArgs<MemberMobileScreenArguments>(
        orElse: () => MemberMobileScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberMobileScreen(key: args.key),
        settings: data,
      );
    },
    MemberOtpScreen: (data) {
      final args = data.getArgs<MemberOtpScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MemberOtpScreen(
          key: args.key,
          phone: args.phone,
          type: args.type,
        ),
        settings: data,
      );
    },
    PdfViewer: (data) {
      final args = data.getArgs<PdfViewScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PdfViewer(

          pdfUrl: args.pdfUrl,

        ),
        settings: data,
      );
    },
    ActivityReportScreen: (data) {
      final args = data.getArgs<ActivityReportScreenArguments>(
        orElse: () => ActivityReportScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ActivityReportScreen(key: args.key),
        settings: data,
      );
    },
    PrivacyScreen: (data) {
      final args = data.getArgs<PrivacyScreenArguments>(
        orElse: () => PrivacyScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PrivacyScreen(key: args.key),
        settings: data,
      );
    },
    TearmsScreen: (data) {
      final args = data.getArgs<TearmsScreenArguments>(
        orElse: () => TearmsScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TearmsScreen(key: args.key),
        settings: data,
      );
    },
    FaqScreen: (data) {
      final args = data.getArgs<FaqScreenArguments>(
        orElse: () => FaqScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FaqScreen(key: args.key),
        settings: data,
      );
    },
    SearchScreen: (data) {
      final args = data.getArgs<SearchScreenArguments>(
        orElse: () => SearchScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchScreen(key: args.key),
        settings: data,
      );
    },
    SearchServiceScreen: (data) {
      final args = data.getArgs<SearchServiceScreenArguments>(
        orElse: () => SearchServiceScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchServiceScreen(key: args.key),
        settings: data,
      );
    },
    CalenderScreen: (data) {
      final args = data.getArgs<CalenderScreenArguments>(
        orElse: () => CalenderScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CalenderScreen(key: args.key),
        settings: data,
      );
    },
    RecordVitalScreen: (data) {
      final args = data.getArgs<RecordVitalScreenArguments>(
        orElse: () => RecordVitalScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecordVitalScreen(key: args.key),
        settings: data,
      );
    },
    SingleRecordVital: (data) {
      final args = data.getArgs<SingleRecordVitalArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleRecordVital(
          key: args.key,
          record: args.record,
        ),
        settings: data,
      );
    },
    FamilyListScreen: (data) {
      final args = data.getArgs<FamilyListScreenArguments>(
        orElse: () => FamilyListScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FamilyListScreen(key: args.key),
        settings: data,
      );
    },
    MedicineListScreen: (data) {
      final args = data.getArgs<MedicineListScreenArguments>(
        orElse: () => MedicineListScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MedicineListScreen(key: args.key),
        settings: data,
      );
    },
    ImmunizationListScreen: (data) {
      final args = data.getArgs<ImmunizationListScreenArguments>(
        orElse: () => ImmunizationListScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ImmunizationListScreen(key: args.key),
        settings: data,
      );
    },

    PurchagePlanListScreen: (data) {
      final args = data.getArgs<PurchagePlanListScreenArguments>(
        orElse: () => PurchagePlanListScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PurchagePlanListScreen(key: args.key),
        settings: data,
      );
    },
    AppointmentDetailScreen: (data) {
      final args =
          data.getArgs<AppointmentDetailScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppointmentDetailScreen(
          key: args.key,
          appointment: args.appointment,
        ),
        settings: data,
      );
    },
    RecordView: (data) {
      final args = data.getArgs<RecordViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecordView(
          key: args.key,
          record: args.record,
        ),
        settings: data,
      );
    },
    ViewPastScreen: (data) {
      final args = data.getArgs<ViewPastScreenArguments>(
        orElse: () => ViewPastScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewPastScreen(
          key: args.key,
          title: args.title,
        ),
        settings: data,
      );
    },
    EcgScreen: (data) {
      final args = data.getArgs<EcgScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EcgScreen(
          key: args.key,
          record: args.record,
        ),
        settings: data,
      );
    },
    SearchMemberScreen: (data) {
      final args = data.getArgs<SearchMemberScreenArguments>(
        orElse: () => SearchMemberScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchMemberScreen(key: args.key),
        settings: data,
      );
    },
    UploadScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UploadScreen(),
        settings: data,
      );
    },
    ReportDetailScreen: (data) {
      final args = data.getArgs<ReportDetailScreenArguments>(
        orElse: () => ReportDetailScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ReportDetailScreen(
          vitalVals: args.vitalVals,
          isSearch: args.isSearch,
          masterKeyLabels: args.masterKeyLabels,
          reportLabs: args.reportLabs,
        ),
        settings: data,
      );
    },
    TrendReport: (data) {
      final args = data.getArgs<TrendReportArguments>(
        orElse: () => TrendReportArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TrendReport(
          key: args.key,
          test: args.test,
          uniquekey: args.uniquekey,
          patientid: args.patientid,
        ),
        settings: data,
      );
    },
    AppointmentPayment: (data) {
      final args = data.getArgs<AppointmentPaymentArguments>(
        orElse: () => AppointmentPaymentArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            AppointmentPayment(appointment_id: args.appointment_id,

            type:args.type,
                pckgitem:args.pckgitem

            ),
        settings: data,
      );
    },
    AddNewMember: (data) {
      final args = data.getArgs<AddNewMemberArguments>(
        orElse: () => AddNewMemberArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            AddNewMember(appointment_id: args.appointment_id,
                specialist: args.specialist,
                date: args.date,
                remark: args.remark,
                phone: args.phone,
                type:args.type

            ),
        settings: data,
      );
    },
    PurchageNewMember: (data) {
      final args = data.getArgs<PurchageNewMemberArguments>(
        orElse: () => PurchageNewMemberArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            PurchageNewMember(
                type:args.type

            ),
        settings: data,
      );
    },

    PurchageAccountNewMember: (data) {
      final args = data.getArgs<PurchageAccountNewMemberArguments>(
        orElse: () => PurchageAccountNewMemberArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            PurchageAccountNewMember(
                type:args.type,

             name:args.name,dateMember:args.dateMember,
                 gender:args.gender,relation:args.relation

            ),
        settings: data,
      );
    },
    // AddNewMemberBookService: (data) {
    //   final args = data.getArgs<AddNewMemberBookServiceArguments>(
    //     orElse: () => AddNewMemberBookServiceArguments(),
    //   );
    //   return MaterialPageRoute<dynamic>(
    //     builder: (context) =>
    //         AddNewMemberBookService(appointment_id: args.appointment_id,
    //             specialist: args.specialist,
    //             date: args.date,
    //             remark: args.remark,
    //             phone: args.phone
    //
    //         ),
    //     settings: data,
    //   );
    // },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// UserTypeScreen arguments holder class
class UserTypeScreenArguments {
  final Key key;
  final Banners banners;
  UserTypeScreenArguments({this.key, this.banners});
}

/// HomeScreen arguments holder class
class HomeScreenArguments {
  final int tab;
  HomeScreenArguments({this.tab});
}

/// AppointmentScreen arguments holder class
class AppointmentScreenArguments {
  final Key key;
  AppointmentScreenArguments({this.key});
}

/// ServiceScreen arguments holder class
class ServiceScreenArguments {
  final Key key;
  ServiceScreenArguments({this.key});
}

/// SettingScreen arguments holder class
class SettingScreenArguments {
  final Key key;
  SettingScreenArguments({this.key});
}

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final UserEntity user;
  ProfileScreenArguments({this.user});
}

/// SubscriptionListScreen arguments holder class
class SubscriptionListScreenArguments {
  final Key key;
  SubscriptionListScreenArguments({this.key});
}

/// HomeDashboardScreen arguments holder class
class HomeDashboardScreenArguments {
  final int tab;
  HomeDashboardScreenArguments({this.tab});
}

/// MemberProfileScreen arguments holder class
class MemberProfileScreenArguments {
  final FamilyMainResult member;
  String carecashAmt;
  MemberProfileScreenArguments({this.member,this.carecashAmt});
}

/// MemberMobileScreen arguments holder class
class MemberMobileScreenArguments {
  final Key key;
  MemberMobileScreenArguments({this.key});
}

/// MemberOtpScreen arguments holder class
class MemberOtpScreenArguments {
  final Key key;
  final String phone,type;
  MemberOtpScreenArguments({this.key, @required this.phone,this.type});
}
class PdfViewScreenArguments {
  final Key key;
  final String pdfUrl;
  PdfViewScreenArguments({this.key, @required this.pdfUrl});
}

/// ActivityReportScreen arguments holder class
class ActivityReportScreenArguments {
  final Key key;
  ActivityReportScreenArguments({this.key});
}

/// PrivacyScreen arguments holder class
class PrivacyScreenArguments {
  final Key key;
  PrivacyScreenArguments({this.key});
}

/// TearmsScreen arguments holder class
class TearmsScreenArguments {
  final Key key;
  TearmsScreenArguments({this.key});
}

/// FaqScreen arguments holder class
class FaqScreenArguments {
  final Key key;
  FaqScreenArguments({this.key});
}

/// SearchScreen arguments holder class
class SearchScreenArguments {
  final Key key;
  SearchScreenArguments({this.key});
}

/// SearchServiceScreen arguments holder class
class SearchServiceScreenArguments {
  final Key key;
  SearchServiceScreenArguments({this.key});
}

/// CalenderScreen arguments holder class
class CalenderScreenArguments {
  final Key key;
  CalenderScreenArguments({this.key});
}

/// RecordVitalScreen arguments holder class
class RecordVitalScreenArguments {
  final Key key;
  RecordVitalScreenArguments({this.key});
}

/// SingleRecordVital arguments holder class
class SingleRecordVitalArguments {
  final Key key;
  final Record record;
  SingleRecordVitalArguments({this.key, @required this.record});
}

/// FamilyListScreen arguments holder class
class FamilyListScreenArguments {
  final Key key;
  FamilyListScreenArguments({this.key});
}

/// MedicineListScreen arguments holder class
class MedicineListScreenArguments {
  final Key key;
  MedicineListScreenArguments({this.key});
}

/// ImmunizationListScreen arguments holder class
class ImmunizationListScreenArguments {
  final Key key;
  ImmunizationListScreenArguments({this.key});
}

class PurchagePlanListScreenArguments {
  final Key key;
  PurchagePlanListScreenArguments({this.key});
}
/// AppointmentDetailScreen arguments holder class
class AppointmentDetailScreenArguments {
  final Key key;
  final AppointmentModel appointment;
  AppointmentDetailScreenArguments({this.key, @required this.appointment});
}

/// RecordView arguments holder class
class RecordViewArguments {
  final Key key;
  final Record record;
  RecordViewArguments({this.key, @required this.record});
}

/// ViewPastScreen arguments holder class
class ViewPastScreenArguments {
  final Key key;
  final String title;
  ViewPastScreenArguments({this.key, this.title});
}

/// EcgScreen arguments holder class
class EcgScreenArguments {
  final Key key;
  final Record record;
  EcgScreenArguments({this.key, @required this.record});
}

/// SearchMemberScreen arguments holder class
class SearchMemberScreenArguments {
  final Key key;
  SearchMemberScreenArguments({this.key});
}

/// ReportDetailScreen arguments holder class
class ReportDetailScreenArguments {
  final List<VitalVal> vitalVals;
  final bool isSearch;
  final List<MasterKeyLabels> masterKeyLabels;
  final String reportLabs;
  ReportDetailScreenArguments(
      {this.vitalVals, this.isSearch, this.masterKeyLabels, this.reportLabs});
}

/// TrendReport arguments holder class
class TrendReportArguments {
  final Key key;
  final String test;
  final String uniquekey;
  final int patientid;
  TrendReportArguments({this.key, this.test, this.uniquekey, this.patientid});
}

/// AppointmentPayment arguments holder class
class AppointmentPaymentArguments {
  final int appointment_id;
  final String type;
  Package pckgitem;
  AppointmentPaymentArguments({this.appointment_id, this.type,this.pckgitem});
}
class AddNewMemberArguments {
  final int appointment_id;
  final String  specialist,
      date,
      remark,
      phone,type;
  AddNewMemberArguments({this.appointment_id,this.specialist,this.date,this.remark,this.phone,this.type});
}
class PurchageNewMemberArguments {
  final String type;
  PurchageNewMemberArguments({this.type});
}
class PurchageAccountNewMemberArguments {
  final String type,name,dateMember;
ServiceType gender,relation;
  PurchageAccountNewMemberArguments({this.type,this.name,this.dateMember,this.relation,this.gender});
}

class AddNewMemberBookServiceArguments {
  final int appointment_id;
  final String  specialist,
      date,
      remark,
      phone;
  AddNewMemberBookServiceArguments({this.appointment_id,this.specialist,this.date,this.remark,this.phone});
}


