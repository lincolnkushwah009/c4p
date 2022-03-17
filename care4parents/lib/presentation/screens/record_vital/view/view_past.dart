import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/vitaltype_bloc.dart';
import 'package:care4parents/presentation/screens/dashboard/view/constants.dart';
import 'package:care4parents/presentation/screens/dashboard/view/vital_chart.dart';

import 'package:care4parents/presentation/screens/menu/view/menu_screen.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewPastScreen extends StatefulWidget {
  final String title;

  ViewPastScreen({Key key, this.title}) : super(key: key);

  @override
  _ViewPastScreenState createState() => _ViewPastScreenState();
}

class _ViewPastScreenState extends State<ViewPastScreen> {
  VitaltypeBloc _vitaltypeBloc;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _vitaltypeBloc = getItInstance<VitaltypeBloc>();
    _vitaltypeBloc
        .add(ChnageRecordType(Constants.switchRecordTitle(widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _vitaltypeBloc,
        ),
      ],
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: BlocBuilder<VitaltypeBloc, VitaltypeState>(
            builder: (context, state) {
              if (state is ChangedRecordListType)
                return CustomAppBar(
                  title: widget.title,
                  hasTrailing:  true,
                  trailing: [

                    widget.title != "ECG"?  buildRaisedButton(theme, state.showGraph):new Container(),

                    widget.title == "ECG" ?new whatappIconwidget(isHeader:true):new Container()
                  ],
                  leading: InkWell(
                      onTap: () => ExtendedNavigator.root.pop(),
                      child: Icon(Icons.arrow_back_ios_outlined)),
                  // onLeadingTap: () => _openDrawer(),
                );
              return CustomAppBar(
                title: widget.title,
                hasTrailing: false,
                leading: InkWell(
                    onTap: () => ExtendedNavigator.root.pop(),
                    child: Icon(Icons.arrow_back_ios_outlined)),
                // onLeadingTap: () => _openDrawer(),
              );
            },
          ),
        ),
        body: Center(
          child: BlocListener<VitaltypeBloc, VitaltypeState>(
            listener: (context, state) {
              // if (state is ChangedRecordListType &&
              //     state.li != null &&
              //     !state.loaded) {}
            },
            child: BlocBuilder<VitaltypeBloc, VitaltypeState>(
                builder: (context, state) {
              if (state is Loading) {
                print('Loading state ====================');
                return new Container(
                  height: heightOfScreen,
                  child: AppLoading(),
                );
              }
              if (state is ChangedRecordListType) {
                print('ChangedRecordListType =====================' +
                    state.list.toString());
                if (state.list != null && state.list.length > 0) {
                  if (state.showGraph) {
                    return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          final VitalTypeResult type = state.list[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PastCardWidget(
                                index: index, type: type, title: widget.title),
                          );
                        });
                  } else {
                    return BgCard(
                        padding:
                            EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
                        width: widthOfScreen * 0.9,
                        height: heightOfScreen * 0.5,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(Sizes.RADIUS_24),
                        ),
                        child: VitalChart(vitalTypes: state.list));
                  }
                } else {
                  return buildNotFoundCard(theme);
                }
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }

  RaisedButton buildRaisedButton(ThemeData theme, bool showGraph) {
    return RaisedButton(
      color: AppColors.lightButton,
      hoverColor: AppColors.lightButton,
      onPressed: () {
        _vitaltypeBloc.add(ChangeRecordListType(showGraph: !showGraph));
      },
      child: showGraph
          ? Row(
              children: [
                Text(
                  'Graph',
                  style: theme.textTheme.bodyText1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
                SpaceW4(),
                Icon(
                  Icons.show_chart,
                  color: AppColors.white,
                  size: 12,
                )
              ],
            )
          : Row(
              children: [
                Text(
                  'List',
                  style: theme.textTheme.bodyText1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
                SpaceW4(),
                Icon(
                  Icons.list,
                  color: AppColors.white,
                )
              ],
            ),
    );
  }

  Center buildNotFoundCard(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringConst.sentence.NOT_FOUND,
              textAlign: TextAlign.center,
              style:
                  theme.textTheme.caption.copyWith(color: AppColors.noDataText),
            ),
            SpaceH8(),
          ],
        ),
      ),
    );
  }
}

class PastCardWidget extends StatelessWidget {
  final int index;
  final VitalTypeResult type;
  final String title;

  const PastCardWidget({
    Key key,
    @required this.index,
    @required this.title,
    @required this.type,
  }) : super(key: key);

  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(top: Sizes.MARGIN_12),
      child: Material(
        elevation: Sizes.ELEVATION_10,
        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   RouteList.appointmentDetail,
            //   arguments: AppointmentDetailArguments(activityId),
            // );
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
              child: Padding(
                padding: EdgeInsets.all(
                  ((Sizes.PADDING_8).w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title != null ? title : '',
                          style: theme.textTheme.headline6.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        title == "ECG"
                            ? new GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringConst.VIEW_REPORT,
                                      style: theme.textTheme.caption.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12,
                                      color: AppColors.primaryColor,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  print(
                                      "reportlink>> https://apis.care4parents.in/uploads/" +
                                          jsonDecode(type.ecgfiles)["docurl"]);
                                  _launchURL(
                                      jsonDecode(type.ecgfiles)["docurl"]);
                                },
                              )
                            : new Container(),
                      ],
                    ),
                    // SpaceH4(),

                    SpaceH4(),

                    LabelValue(
                      label: 'Measure On',
                      value: type.measureOn != null
                          ? DateFormat.yMMMd()
                              .add_jms() //("yyyy-MM-dd hh:mm:ss")
                              .format(type.measureOn)
                          : '---',
                      theme: theme,
                    ),
                    type.value != null
                        ? LabelValue(
                            label: 'Value',
                            value: type.value != null ? type.value : '',
                            theme: theme,
                          )
                        : new Container(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class LabelValue extends StatelessWidget {
  const LabelValue({
    Key key,
    @required this.label,
    @required this.value,
    @required this.theme,
  }) : super(key: key);

  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.PADDING_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: theme.textTheme.bodyText1
                  .copyWith(fontSize: Sizes.SIZE_16.sp, color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: theme.textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class LabelValuePay extends StatelessWidget {
  const LabelValuePay(
      {Key key,
      @required this.label,
      this.link,
      @required this.value,
      @required this.theme,
      this.onclick})
      : super(key: key);

  final String label;
  final String value;
  final String link;
  final ThemeData theme;
  final Function onclick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.PADDING_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: Sizes.SIZE_16.sp,
              ),
            ),
          ),
          Expanded(
            child: new Row(
              children: [
                new MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  textColor: AppColors.primaryColor,
                  splashColor: AppColors.primaryColor,
                  elevation: 5,
                  height: 35,
                  color: AppColors.primaryColor,
                  onPressed: this.onclick,
                  child: Text(
                    value,
                    style: theme.textTheme.button.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
