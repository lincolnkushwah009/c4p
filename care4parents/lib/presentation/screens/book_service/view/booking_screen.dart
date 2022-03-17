import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_appointment/book_appointment.dart';
// import 'package:care4parents/presentation/screens/book_appointment/view/booking_form.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_service_bloc.dart';
import 'booking_form.dart';

class BookServiceScreen extends StatefulWidget {
  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  BookServiceBloc _serviceBloc;
  // DashboardBloc _dashboardBloc;
  List<FamilyMainResult> members;
  List<FamilyMainResult> dummyMembers;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    asyncSharePref();
    _serviceBloc = getItInstance<BookServiceBloc>();
    // _dashboardBloc = getItInstance<DashboardBloc>();
    // _dashboardBloc.add(GetFamilyList());
  }
  void asyncSharePref() async {
    members = await SharedPreferenceHelper.getFamilyMermbersPref();
    dummyMembers = await SharedPreferenceHelper.getFamilyMermbersPref();



    setState(() {
      loading = false;
    });


  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: StringConst.BOOK_SERVICE_SCREEN,
            // onLeadingTap: () => {ExtendedNavigator.root.pop()},
            leading: InkWell(
                onTap: () => {ExtendedNavigator.root.pop()},
                child: Icon(Icons.arrow_back_ios_outlined)),
            trailing: [
              new whatappIconwidget(isHeader:true)

            ],
            hasTrailing: true),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: heightOfScreen * 0.9,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => _serviceBloc,
                ),
                // BlocProvider(
                //   create: (context) => _dashboardBloc,
                // ),
              ],
              child: BookingForm(members: members,),
            )),
      ),
    );
  }
}
