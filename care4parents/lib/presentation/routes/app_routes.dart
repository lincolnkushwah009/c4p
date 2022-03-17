import 'package:auto_route/auto_route_annotations.dart';
import 'package:care4parents/presentation/screens/Immunization_list/view/immunization_screen.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/PurchageAccountNewMember_screen.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/PurchageNewMember_screen.dart';
import 'package:care4parents/presentation/screens/PurchagePlan_list/view/purchagePlan_screen.dart';
import 'package:care4parents/presentation/screens/appointment_detail/appointment_detail_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/book_appointment.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addCareCash_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/addNewMember_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/date_time.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/payment_screen.dart';
import 'package:care4parents/presentation/screens/book_appointment/view/search_specialist.dart';
import 'package:care4parents/presentation/screens/book_service/book_service.dart';
import 'package:care4parents/presentation/screens/book_service/view/search_member.dart';
import 'package:care4parents/presentation/screens/book_service/view/search_specialist.dart';
import 'package:care4parents/presentation/screens/change_password/change_password.dart';
import 'package:care4parents/presentation/screens/home/home.dart';
import 'package:care4parents/presentation/screens/home_dashboard/view/home_dashboard_screen.dart';
import 'package:care4parents/presentation/screens/medicine_list/view/medicine_screen.dart';
import 'package:care4parents/presentation/screens/member/member.dart';
import 'package:care4parents/presentation/screens/my_family/view/my_family_screen.dart';
// import 'package:care4parents/presentation/screens/home/home.dart';
import 'package:care4parents/presentation/screens/onboading/on_boading_screen.dart';
import 'package:care4parents/presentation/screens/other/view/faq_screen.dart';

import 'package:care4parents/presentation/screens/other/view/privacy_screen.dart';
import 'package:care4parents/presentation/screens/other/view/tearm_screen.dart';
import 'package:care4parents/presentation/screens/otp/otp.dart';
import 'package:care4parents/presentation/screens/edit_profile/profile.dart';
import 'package:care4parents/presentation/screens/record_vital/view/record_view.dart';
import 'package:care4parents/presentation/screens/record_vital/view/record_vital_screen.dart';
import 'package:care4parents/presentation/screens/record_vital/view/ecg_screen.dart';
import 'package:care4parents/presentation/screens/record_vital/view/single_record_vital.dart';
import 'package:care4parents/presentation/screens/record_vital/view/view_past.dart';
import 'package:care4parents/presentation/screens/report_detail/view/report_detail_screen.dart';
import 'package:care4parents/presentation/screens/report_detail/view/trend_report.dart';
import 'package:care4parents/presentation/screens/service/service.dart';
import 'package:care4parents/presentation/screens/splash_screen.dart';
import 'package:care4parents/presentation/screens/subscription_add/index.dart';
import 'package:care4parents/presentation/screens/upload_report/view/upload_screen.dart';
import 'package:care4parents/presentation/screens/welcome/user_type_screen.dart';
import 'package:care4parents/presentation/screens/welcome/welcome_screen.dart';
import 'package:care4parents/presentation/screens/signup/signup.dart';
import 'package:care4parents/presentation/screens/login/login.dart';
import 'package:care4parents/presentation/screens/forgot_password/forgot_password.dart';
import 'package:care4parents/presentation/screens/appontment/appointment.dart';
import 'package:care4parents/presentation/screens/settings/settings.dart';
import 'package:care4parents/presentation/screens/subscription_list/view/subscription_screen.dart';
// import 'package:care4parents/presentation/screens/dashboard/dashboard.dart';
import 'package:care4parents/presentation/screens/member_profile/member_profile.dart';
import 'package:care4parents/presentation/screens/activity_report/activity_report.dart';

import 'auth_guard.dart';

// flutter packages pub run build_runner watch
// flutter packages pub run build_runner watch --delete-conflicting-outputs
@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: OnBoardingScreen),
    // MaterialRoute(page: HomeScreen),
    MaterialRoute(page: WelcomeScreen),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: SignupScreen),
    MaterialRoute(page: UserTypeScreen),
    MaterialRoute(page: OtpScreen),
    MaterialRoute(page: HomeScreen, guards: [AuthGuard]),
    MaterialRoute(page: AppointmentScreen, guards: [AuthGuard]),
    MaterialRoute(page: BookAppointmentScreen, guards: [AuthGuard]),
    MaterialRoute(page: ServiceScreen, guards: [AuthGuard]),
    MaterialRoute(page: BookServiceScreen, guards: [AuthGuard]),
    MaterialRoute(page: ForgotPasswordScreen),
    MaterialRoute(page: SettingScreen),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: ChangePasswordScreen),
    MaterialRoute(page: SubscriptionListScreen),
    MaterialRoute(page: SubscriptionAddScreen),
    MaterialRoute(page: HomeDashboardScreen),
    MaterialRoute(page: MemberProfileScreen),
    MaterialRoute(page: MemberMobileScreen),
    MaterialRoute(page: MemberOtpScreen),
    MaterialRoute(page: ActivityReportScreen),
    MaterialRoute(page: PrivacyScreen),
    MaterialRoute(page: TearmsScreen),
    MaterialRoute(page: FaqScreen),
    MaterialRoute(page: SearchScreen),
    MaterialRoute(page: SearchServiceScreen),
    MaterialRoute(page: CalenderScreen),
    MaterialRoute(page: RecordVitalScreen),
    MaterialRoute(page: SingleRecordVital),
    MaterialRoute(page: FamilyListScreen),
    MaterialRoute(page: MedicineListScreen),
    MaterialRoute(page: ImmunizationListScreen),
    MaterialRoute(page: AppointmentDetailScreen),
    MaterialRoute(page: RecordView),
    MaterialRoute(page: ViewPastScreen),
    MaterialRoute(page: EcgScreen),
    MaterialRoute(page: SearchMemberScreen),
    MaterialRoute(page: UploadScreen),
    MaterialRoute(page: ReportDetailScreen),
    MaterialRoute(page: TrendReport),
    MaterialRoute(page: AppointmentPayment),
    MaterialRoute(page: AddNewMember),
    MaterialRoute(page: PurchagePlanListScreen),
    MaterialRoute(page: PurchageNewMember),
    MaterialRoute(page: PurchageAccountNewMember),
    MaterialRoute(page: AddCareCashScreen),


  ],
)
class $AppRouter {}
// flutter packages pub run build_runner watchö
