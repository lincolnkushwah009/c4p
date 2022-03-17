import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/MedicineModel.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/confrence_list/bloc/conference_list_bloc.dart';
import 'package:care4parents/presentation/screens/confrence_list/view/conference_card_widget.dart';

import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';

import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicineListScreen extends StatefulWidget {
  MedicineListScreen({Key key}) : super(key: key);

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  // ProfileBloc _profileBloc;
  ConferenceListBloc _medicineListBloc;
  DrawerBloc _drawerBloc;
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  var scaffoldKey = GlobalKey<ScaffoldState>();
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
    _medicineListBloc = getItInstance<ConferenceListBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _medicineListBloc.add(GetConference());
  }

  void _openDrawer() {
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
          create: (context) => _medicineListBloc,
        ),
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            drawer: MenuScreen(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
              child: CustomAppBar(
                  title: StringConst.MEDICINE,
                  onLeadingTap: () => _openDrawer(),
                  hasTrailing: false),
            ),
            body: BlocBuilder<ConferenceListBloc, ConferenceListState>(
                builder: (context, state) {
              if (state is Loading) return AppLoading();
              if (state is Loaded)
                return Container(
                  child: (state.invoices?.isEmpty ?? true)
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.PADDING_14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  StringConst.sentence.No_Medicine,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.subtitle1
                                      .copyWith(color: AppColors.noDataText),
                                ),
                                SpaceH36(),
                                // Container(
                                //   margin: const EdgeInsets.symmetric(
                                //       horizontal: Sizes.MARGIN_48),
                                //   child: CustomButton(
                                //       color: AppColors.primaryColor,
                                //       height: Sizes.HEIGHT_50,
                                //       borderRadius: Sizes.RADIUS_4,
                                //       textStyle:
                                //           theme.textTheme.subtitle1.copyWith(
                                //         color: AppColors.white,
                                //       ),
                                //       onPressed: () => onBookPress(),
                                //       title: CommonButtons.BOOK),
                                // ),
                              ],
                            ),
                          ),
                        )
                      : ListView(
                          // physics: BouncingScrollPhysics(),
                          children: [
                            ..._buildSubscriptionListTile(
                                context: context, data: state.invoices)
                          ],
                        ),
                );

              return Container();
            }));
      }),
    );
  }

  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  List<Widget> _buildSubscriptionListTile(
      {@required BuildContext context,
      @required List<MedicineData> data,
      @required Theme theme}) {
    List<Widget> items = [];
    TextTheme textTheme = Theme.of(context).textTheme;

    for (int index = 0; index < data.length; index++) {
      MedicineData sub = data[index];
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(sub.startDate);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputDate = newFormat.format(inputDate);
      DateTime parseDateend =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(sub.endDate);
      var inputDateend = DateTime.parse(parseDateend.toString());
      var outputDateend = newFormat.format(inputDateend);
      print(outputDate);
      items.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_10),
          child: ConferenceCardWidget(
              name:
                  sub.medicineinfo.name != null && sub.medicineinfo.name != null
                      ? sub.medicineinfo.name
                      : '',
              route: sub.route != null && sub.route != "" ? sub.route : '',
              intake: sub.intake != null && sub.intake != "" ? sub.intake : '',
              startDate: sub.startDate != null && sub.startDate != ""
                  ? outputDate
                  : '',
              endDate:
                  sub.endDate != null && sub.endDate != "" ? outputDateend : "",
              remarks:
                  sub.remarks != null && sub.remarks != "" ? sub.remarks : '',
              openlink: () {
                print("prescriptionFile>> " + sub.prescriptionFile);
                _launchURL(sub.prescriptionFile);
              },
              prescription_file: sub.prescriptionFile),
        ),
      );
    }

    return items;
  }

  void refreshData() {
    // _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }
}

void goToSubscription() {
  ExtendedNavigator.root.push(Routes.subscriptionAddScreen);
}
