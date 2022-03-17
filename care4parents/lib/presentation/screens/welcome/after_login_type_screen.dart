import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/ImmunizationModel.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/Immunization_list/bloc/immunization_list_bloc.dart';
import 'package:care4parents/presentation/screens/Immunization_list/view/immunization_card_widget.dart';
import 'package:care4parents/presentation/screens/appontment/view/appointment_screen.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/screens/otp/otp.dart';
import 'package:care4parents/presentation/screens/subscription_flow/view/subscription_flow_screen.dart';
import 'package:care4parents/presentation/screens/welcome/UIModel.dart';
import 'package:care4parents/presentation/screens/welcome/bloc/home_list_bloc.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/auth/bg_card_auto.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/logo_widget.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double kPadding = Sizes.PADDING_14;

class HomePageController {
  void Function() methodA;
}

class LginTypeScreen extends StatefulWidget {
  LginTypeScreen({Key key}) : super(key: key);

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<LginTypeScreen> {
  // ProfileBloc _profileBloc;
  HomeListBloc _immunizationListBloc;
  DrawerBloc _drawerBloc;
  DashboardBloc _dashboardBloc;
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = true,isButtonDisabled=false;

  FamilyMember member;
  final HomePageController myController = HomePageController();
  User user;
  String _mobile;
  // List<Subscription> subscriptions = [
  //   Subscription(
  //       id: 1354,
  //       name: 'John',
  //       subscription_date: '2021-04-12',
  //       package: 'Gold',
  //       amount: "200"),
  //   Subscription(
  //       id: 354,
  //       name: 'John1',
  //       subscription_date: '2021-04-01',
  //       package: 'Gold',
  //       amount: "200")
  // ];

  @override
  void initState() {
    super.initState();
    _immunizationListBloc = getItInstance<HomeListBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _immunizationListBloc.add(GetUserFamilyppcount());
    _dashboardBloc = getItInstance<DashboardBloc>();
    getUserData();
  }

  getUserData() async {
    user = await SharedPreferenceHelper.getUserPref();
    print("dsds" + user.name);
    setState(() {});
  }

  void _openDrawer() {
    if (myController.methodA != null) myController.methodA();
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _immunizationListBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => _dashboardBloc
            ..add(
              GetFamilyList(),
            ),
        ),
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            drawer: MenuScreen(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
              child: CustomAppBar(
                  onLeadingTap: () => _openDrawer(),
                  title: StringConst.APP_Home,
                  trailing: [new whatappIconwidget(isHeader: true)],
                  hasTrailing: true),
            ),
            body: BlocListener<HomeListBloc, HomeListState>(
                listener: (context, state) {
                  if(state.msg.value!=""){
                    failureSnackBar(context, message: state.msg.value.toString());

                    setState(() {
                      isButtonDisabled=false;
                    });
                  }


                  print("fm_counts>> " + state.fm_counts.value);
                },
                child: new Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('Welcome back',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    Text(user != null ? user.name : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20)),
                    _EmailInput(isButtonDisabled:isButtonDisabled,onPresSOS:(){

                      setState(() {
                        isButtonDisabled=true;
                      });

                    })
                  ],
                )));
      }),
    );
  }

  void failureSnackBar(BuildContext context, {String message = null}) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
                message != null ? message : StringConst.sentence.LOGIN_FAILED)),
      );
  }

  void refreshData() {
    // _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }
}

class _EmailInput extends StatelessWidget {
 Function onPresSOS;
  bool isButtonDisabled;
  _EmailInput({
    Key key,
    this.isButtonDisabled,this.onPresSOS
  }) : super(key: key);
  void onPressBookService() {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    SharedPreferenceHelper.setCareCashpatientIdPref(null);
    ExtendedNavigator.root.push(Routes.bookServiceScreen);
    // ExtendedNavigator.root.push(Routes.bookServiceScreen).then(onGoBack);
    // ;
  }

  void onPressDashboard() {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    SharedPreferenceHelper.setCareCashpatientIdPref(null);
    ExtendedNavigator.root.push(Routes.homeDashboardScreen);
    // ExtendedNavigator.root.push(Routes.bookServiceScreen).then(onGoBack);
    // ;
  }

  void onPressAddCareCash() {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    SharedPreferenceHelper.setCareCashpatientIdPref(null);
    ExtendedNavigator.root.push(Routes.addCareCashScreen);
  }

  void onPressSOS() {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    // ExtendedNavigator.root.push(Routes.homeDashboardScreen);
    // ExtendedNavigator.root.push(Routes.bookServiceScreen).then(onGoBack);
    // ;
    // _immunizationListBloc.add(GetuserSos());
  }

  void onPressBookAppointment() {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    SharedPreferenceHelper.setCareCashpatientIdPref(null);
    ExtendedNavigator.root.push(Routes.bookAppointmentScreen);
    // ExtendedNavigator.root.push(Routes.bookServiceScreen).then(onGoBack);
    // ;
  }

  void onPressPurchagePlan() async {
    SharedPreferenceHelper.setBookServiceIdPref(null);
    SharedPreferenceHelper.setAppointmentIdPref(null);
    SharedPreferenceHelper.setCareCashpatientIdPref(null);
    ExtendedNavigator.root.push(Routes.purchagePlanListScreen);
  }

  void onPressReport() async {
    ExtendedNavigator.root
        .push(Routes.homeScreen, arguments: HomeScreenArguments(tab: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(right: 14,left: 14),
            child: Column(
          // physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new GestureDetector(
                  onTap: () {
                    if (state?.fm_counts.value != null &&
                        state?.fm_counts.value != "0") {
                      onPressReport();
                     // onPressPurchagePlan();
                    } else {
                      onPressPurchagePlan();
                    }
                  },
                  child: buildBox(
                      160, MediaQuery.of(context).size.width / 2.5, 0,(state?.fm_counts.value != null &&
                      state?.fm_counts.value != "0")?"0": "",false),
                ),
                new GestureDetector(


                  onTap:isButtonDisabled?null: () {
                   this.onPresSOS();
                    context.read<HomeListBloc>().add(const GetuserSos());
                  },
                  child: buildBox(
                      160, MediaQuery.of(context).size.width / 2, 1, "",isButtonDisabled),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new GestureDetector(
                  onTap: () {
                    onPressBookService();
                  },
                  child: buildBox(
                      160, MediaQuery.of(context).size.width / 2, 2, "",false),
                ),
                new GestureDetector(
                  onTap: () {
                    onPressBookAppointment();
                  },
                  child: buildBox(
                      160, MediaQuery.of(context).size.width / 2.5, 3, "",false),
                )
              ],
            ),
            (state.fm_counts.value != null && state.fm_counts.value != "0")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new GestureDetector(
                        onTap: () {
                          onPressDashboard();
                        },
                        child: buildBox(
                            160, MediaQuery.of(context).size.width /2.5, 4, "",false),
                      ),
                      new GestureDetector(
                        onTap: () {
                          onPressAddCareCash();
                        },
                        child: buildBox(
                            160, MediaQuery.of(context).size.width / 2, 5, "",false),
                      )
                    ],
                  )
                : new Container(),
          ],
        ));
      },
    );
  }

  // BlocBuilder<ImmunizationListBloc, ImmunizationListState>(
  //
  // builder: (context, state) {
  // return ,
  // ); }),

}




buildBox(double height, double width, int i, String fmCount,bool isButtonDisabled) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    padding: const EdgeInsets.all(8),
    color:!isButtonDisabled? UIData.sampleData[i].color:AppColors.redShadeDisable,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Image.asset(
        //   UIData.sampleData[i].backgroundicon,
        //   height: 50,
        // ),
        IconButton(
          icon: FaIcon(  fmCount !=""  ? FontAwesomeIcons.fileAlt :UIData.sampleData[i].backgroundicon,size: 40,color: AppColors.white,),

        ),

        // IconButton(
        //   icon: FaIcon(FontAwesomeIcons.moneyBillAlt),
        //
        // ),
        //
        // IconButton(
        //   icon: FaIcon(FontAwesomeIcons.userMd),
        //
        // ),
        //
        // IconButton(
        //   icon: FaIcon(FontAwesomeIcons.stethoscope),
        //
        // ),
        // IconButton(
        //   icon: FaIcon(FontAwesomeIcons.bell),
        //
        // ),
        //
        // IconButton(
        //   icon: FaIcon(FontAwesomeIcons.fileAlt),
        // ),
        Text(
          fmCount !=""  ? 'Report' : UIData.sampleData[i].text,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}


