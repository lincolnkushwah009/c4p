import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user.dart';
import 'package:care4parents/helper/permission_helper.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/screens/record_vital/model/record.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/family_list.dart';
import 'package:care4parents/di/get_it.dart';

import 'package:flutter/foundation.dart';

class RecordVitalScreen extends StatefulWidget {
  RecordVitalScreen({Key key}) : super(key: key);
  // final String title;

  @override
  _RecordVitalScreenState createState() => new _RecordVitalScreenState();
}

class Item {
  final String image;
  final String name;
  bool isSelected;
  Record record;
  Item(
      {@required this.image,
      @required this.name,
      this.isSelected,
      @required this.record});
}

class _RecordVitalScreenState extends State<RecordVitalScreen> {
  TextEditingController editingController = TextEditingController();
  static const platform = const MethodChannel('com.agatsa.sanketlife/ecg');
  FamilyMember member;
  String _mobile;
  final HomePageController myController = HomePageController();

  User user;
  final List<Item> duplicateItems = [
    Item(
      name: 'ECG',
      image: ImagePath.HEART_ICON,
      isSelected: false,
      record: Record(
          title: 'ECG',
          desc: 'Measure your ECG  level using ...',
          imagePath: ImagePath.ECG1,
          screekKey: 'takeEcg'),
    ),
    Item(
        name: 'SPO2',
        image: ImagePath.LEVEAR_ICON,
        isSelected: false,
        record: Record(
            title: 'SPO2',
            desc:
                'Place index finger on the red sensor.  \n\nAs shown in the figure Keep your hands in the same position for 15 second on the sensor.',
            imagePath: ImagePath.BPspo,
            screekKey: 'takeSpo2')),
    Item(
        name: 'Blood Pressure',
        image: ImagePath.BL_PRESSURE,
        isSelected: false,
        record: Record(
            title: 'Blood Pressure',
            desc:
                'Place index finger on the red sensor.  \n\nAs shown in the figure Keep your hands in the same position for 15 second on the sensor.',
            imagePath: ImagePath.BPspo,
            screekKey: 'takeBP')),
    Item(
        name: 'Blood Sugar',
        image: ImagePath.BS,
        isSelected: false,
        record: Record(
            title: 'Blood Sugar',
            desc: 'Measure your blood sugar level using glucometer ...',
            imagePath: ImagePath.BLOOD_SUGAR,
            screekKey: 'takeTemperature')),
    Item(
        name: 'Temperature',
        image: ImagePath.TEMPERATURE_Main,
        isSelected: false,
        record: Record(
            title: 'Temperature',
            desc:
                'Hold the device infront of forehead  As shown in the figure.',
            imagePath: ImagePath.temp,
            screekKey: 'takeTemperature'))
  ];
  var items = List<Item>();
  DrawerBloc _drawerBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true;
  DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    PermissionHelper.allServices();
    PermissionHelper.bluetooth();
    asyncSharePref();
    _dashboardBloc = getItInstance<DashboardBloc>();

    items.addAll(duplicateItems);

    _drawerBloc = DrawerBloc();
  }

  void asyncSharePref() async {
    member = await SharedPreferenceHelper.getFamilyPref();
    user = await SharedPreferenceHelper.getUserPref();
    if (member != null || user != null) {
      print('member >>>>>>>>>>>>' + member.toString());
      print('user >>>>>>>>>>>>>' + user.toString());
      if (member != null) {
        _mobile = member.phone;
        _dashboardBloc.add(GetMemberList());
      }
      if (user != null) {
        _dashboardBloc.add(GetFamilyList());
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggle(Item item) {
    final i = items.firstWhere((item) => item.name == item.name);

    setState(() => i.isSelected = !i.isSelected);
  }

  Future familyList() async {
    final result = await SharedPreferenceHelper.getFamilyMermbersPref();
    print('result ====>' + result.toString());
    return result;
  }

  Future selectedFamilyMember() async {
    return await SharedPreferenceHelper.getSelectedFamilyPref();
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
        BlocProvider(
          lazy: false,
          create: (context) => _dashboardBloc,
        ),
      ],
      child: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is LoadedFamilyList) {
            if (state.userList.length > 0)
              _mobile = state.userList[0].family_member.phone;
          }
        },
        child: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (BuildContext context, DrawerState state) => Scaffold(
            key: scaffoldKey,
            drawer: member != null ? MenuScreen(isFamily: true) : null,
            appBar: !isLoading
                ? PreferredSize(
                    preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                    child: member != null
                        ? CustomAppBar(
                            hasTrailing: true,
                            title: StringConst.RECORD_VITALS,
                            onLeadingTap: () => _openDrawer(),
                            trailing: [
                                BlocBuilder<DashboardBloc, DashboardState>(
                                    builder: (context, state) {
                                  if ((state is LoadedFamilyList) &&
                                      state.userList != null &&
                                      state.userList.length > 0) {
                                    return Container(
                                        child: FamilyMemberList(
                                      controller: myController,
                                      userFamily: state.userList,
                                      selectedId: state.selectedId,
                                      onChange: (index) {
                                        context.read<DashboardBloc>().add(
                                            UpdateSelectedFamilyMemberId(
                                                state.userList[index],
                                                state.userList[index]
                                                    .family_member.id));
                                        _mobile = state.userList[index]
                                            .family_member.phone;
                                        // ;login
                                        // print(index);
                                        // goToMemberProfile(state.userList[index]);
                                      },
                                    ));
                                  }
                                  return Container();
                                }),
                              new whatappIconwidget(isHeader:true)
                              ])
                        : CustomAppBar(
                            title: StringConst.RECORD_VITALS,
                            leading: InkWell(
                                onTap: () => ExtendedNavigator.root.pop(),
                                child: Icon(Icons.arrow_back_ios_outlined)),
                            hasTrailing: true,
                            trailing: [
                              BlocBuilder<DashboardBloc, DashboardState>(
                                builder: (context, state) {
                                  if ((state is LoadedFamilyList) &&
                                      state.userList != null &&
                                      state.userList.length > 0) {
                                    return Container(
                                        child: FamilyMemberList(
                                      controller: myController,
                                      userFamily: state.userList,
                                      selectedId: state.selectedId,
                                      onChange: (index) {
                                        context.read<DashboardBloc>().add(
                                            UpdateSelectedFamilyMemberId(
                                                state.userList[index],
                                                state.userList[index]
                                                    .family_member.id));
                                        _mobile = state.userList[index]
                                            .family_member.phone;
                                        // ;login
                                        // print(index);
                                        // goToMemberProfile(state.userList[index]);
                                      },
                                    ));
                                  }
                                  //  if (state is UpdateSelectedFamily &&
                                  //     state.userList != null &&
                                  //     state.userList.length > 0) {
                                  //   return Container(
                                  //       child: FamilyMemberList(
                                  //     controller: myController,
                                  //     userFamily: state.userList,
                                  //     selectedId: state.selectedId,
                                  //     onChange: (index) {
                                  //       context.read<DashboardBloc>().add(
                                  //           UpdateSelectedFamilyMemberId(
                                  //               state.userList[index],
                                  //               state.userList[index]
                                  //                   .family_member.id));
                                  //       _mobile = state.userList[index]
                                  //           .family_member.phone;
                                  //     },
                                  //   ));
                                  // }
                                  else {
                                    return FutureBuilder(
                                        // get the languageCode, saved in the preferences
                                        future: Future.wait([
                                          familyList(),
                                          selectedFamilyMember()
                                        ]),
                                        // initialData: 'en',
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<dynamic>>
                                                snapshot) {
                                          List<FamilyMainResult> familyMembers =
                                              [];
                                          FamilyMainResult selected;
                                          if (snapshot?.data != null)
                                            familyMembers = snapshot?.data[0];

                                          if (snapshot?.data !=
                                              null) //familyMembers
                                            selected = snapshot?.data[
                                                1]; //selectedFamilyMember

                                          return snapshot.hasData
                                              ? Container(
                                                  child: FamilyMemberList(
                                                  controller: myController,
                                                  userFamily: familyMembers !=
                                                              null &&
                                                          familyMembers.length >
                                                              0
                                                      ? familyMembers
                                                      : [],
                                                  selectedId: selected != null
                                                      ? selected
                                                          .family_member.id
                                                      : null,
                                                  onChange: (index) {
                                                    context
                                                        .read<DashboardBloc>()
                                                        .add(UpdateSelectedFamilyMemberId(
                                                            snapshot
                                                                .data[index],
                                                            snapshot
                                                                .data[index]
                                                                .family_member
                                                                .id));
                                                    _mobile = snapshot
                                                        .data[index]
                                                        .family_member
                                                        .phone;
                                                  },
                                                ))
                                              : Container();
                                        });
                                  }
                                  {
                                    return Container();
                                  }
                                },
                              ),
                              new whatappIconwidget(isHeader:true)
                            ],
                          ))
                : null,
            body: GestureDetector(
              onTap: () {
                myController.methodA();
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('What vitals do you want to record ?',
                          style: theme.textTheme.caption
                              .copyWith(color: AppColors.grey)),
                    ),
                    Expanded(
                      child: RecordVitalList(
                          items: items,
                          widthOfScreen: widthOfScreen,
                          heightOfScreen: heightOfScreen,
                          theme: theme),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
    if (myController.methodA != null) myController.methodA();
  }
}

class RecordVitalList extends StatelessWidget {
  const RecordVitalList({
    Key key,
    @required this.items,
    @required this.widthOfScreen,
    @required this.heightOfScreen,
    @required this.theme,
  }) : super(key: key);

  final List<Item> items;
  final double widthOfScreen;
  final double heightOfScreen;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BgCard(
                padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
                width: widthOfScreen,
                height: heightOfScreen * 0.15,
                backgroundColor:
                    item.isSelected ? AppColors.primaryColor : AppColors.white,
                borderColor: AppColors.primaryColor,
                borderWidth: 2.0,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(Sizes.RADIUS_10),
                ),
                child: Center(
                  child: ListTile(
                    onTap: () async {
                      print(item.record.title);
                      if (item.record.title == 'Blood Sugar') {
                        ExtendedNavigator.root.push(Routes.viewPastScreen,
                            arguments: ViewPastScreenArguments(
                                title: item.record.title));
                      } else if (item.record.title == 'Temperature') {
                        ExtendedNavigator.root.push(Routes.singleRecordVital,
                            arguments: SingleRecordVitalArguments(
                                record: item.record));
                      } else {
                        ExtendedNavigator.root.push(Routes.recordView,
                            arguments:
                                RecordViewArguments(record: item.record));
                      }
                    },
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      height: heightOfScreen,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          item.image,
                          // height: heightOfScreen * 0.1,
                          // width: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text(item.name,
                        style: theme.textTheme.subtitle1.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
