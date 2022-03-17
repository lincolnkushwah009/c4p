import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/data_sources/other_remote_data_source.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/family_member_result.dart';
import 'package:care4parents/data/models/report_detail.dart';
import 'package:care4parents/data/models/trend_main.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/book_service/view/booking_text_form_field.dart';
import 'package:care4parents/presentation/screens/dashboard/view/vital_table.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/util/SizeConfig.dart';
import 'package:care4parents/values/values.dart';
// import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportDetailScreen extends StatefulWidget {
  final List<VitalVal> vitalVals;
  final List<MasterKeyLabels> masterKeyLabels;
  final String reportLabs;
  final bool isSearch;

  ReportDetailScreen(
      {this.vitalVals, this.isSearch, this.masterKeyLabels, this.reportLabs});

  @override
  _ReportDetailScreenState createState() =>
      _ReportDetailScreenState(this.vitalVals, this.isSearch);
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  OtherCubit _otherCubit;

  List<VitalVal> _vitalVals;
  bool _isSearch = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  bool _isSearching = false;
  String _error;
  final TextEditingController _searchQuery = TextEditingController();
  Timer debounceTimer;
  bool isLoading = true;
  bool isOne = true;

  FamilyMainResult member;

  _ReportDetailScreenState(List<VitalVal> vitalVals, bool isSearch) {
    this._vitalVals = vitalVals;
    this._isSearch = isSearch;
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _otherCubit = getItInstance<OtherCubit>();
    asyncSharePref();
  }

  void asyncSharePref() async {
    member = await SharedPreferenceHelper.getSelectedFamilyPref();
    print('member ------------------' + member.toString());
    setState(() {
      isLoading = false;
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _vitalVals = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _vitalVals = List();
    });
    _otherCubit.getOcrSearch(query);
    if (this._searchQuery.text == query) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _otherCubit,
        )
      ],
      child: isLoading
          ? Scaffold(body: AppLoading())
          : Scaffold(
              key: scaffoldKey,
              appBar: PreferredSize(
                preferredSize: _isSearch
                    ? Size.fromHeight(Sizes.HEIGHT_64)
                    : Size.fromHeight(Sizes.HEIGHT_56),
                child: Container(
                  decoration: new BoxDecoration(
                    // borderRadius: new BorderRadius.circular(16.0),
                    color: AppColors.primaryColor,
                  ),
                  child: _isSearch
                      ? AppBar(
                          centerTitle: true,
                          title: TextField(
                            autofocus: true,
                            controller: _searchQuery,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(end: 16.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                                hintText: "Search Report...",
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        )
                      // Center(
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8.0, vertical: 10.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           InkWell(
                      //               onTap: () => ExtendedNavigator.root.pop(),
                      //               child: Icon(Icons.arrow_back_ios_outlined)),
                      //           BookingTextFormField1(
                      //             controller: _searchQuery,
                      //             key: const Key('loginForm_emailInput_textField'),
                      //             inputWidth: widthOfScreen * 0.8,
                      //             hintText: StringConst.label.SEARCH_REPORT,
                      //             prefixIcon: ImagePath.SEARCH_ICON,
                      //             prefixIconHeight: Sizes.ICON_SIZE_18,
                      //             elevation: 0,
                      //             // onChanged: (value) => {filterSearchResults(value)},
                      //             errorText: null,
                      //             borderRadius: Sizes.RADIUS_4,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   )
                      : CustomAppBar(
                          title: StringConst.REPORT_DETAIL,
                          // onLeadingTap: () => _openDrawer(),
                          leading: InkWell(
                              onTap: () => ExtendedNavigator.root.pop(),
                              child: Icon(Icons.arrow_back_ios_outlined)),
                          trailing: [new whatappIconwidget(isHeader: true)],
                          hasTrailing: true),
                ),
              ),
              body: !_isSearch
                  ? Container(
                      child: _vitalVals != null && _vitalVals.length > 0
                          ? buildBody(context)
                          : Container(
                              height: (SizeConfig.screenHeight != null)
                                  ? (SizeConfig.screenHeight / 100)
                                  : 100.00 * 80,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Report under processing. Please try after some time.'),
                                ),
                              )),
                    )
                  : BlocBuilder<OtherCubit, OtherState>(
                      builder: (context, state) {
                        if (state is OtherInitial) {
                          return Center(
                              child: Text('Type to Search Report...'));
                        } else if (state is Loading) {
                          return AppLoading();
                        } else if (state is LoadedVital) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                state.list != null ? state.list.length : 0,
                            itemBuilder: (context, index) {
                              final patientId = state.list[index].patientId;
                              final uniqueKey = state.list[index].vitalKey;
                              final List<Test> vitalVal =
                                  state.list[index].vitalValue;
                              if (vitalVal.length > 0) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTileCard(
                                      baseColor: AppColors.grey10,
                                      expandedColor: Colors.grey[50],
                                      // key: cardA,
                                      title: new SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.list[index].vitalLabel}" +
                                                  "",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.caption
                                                  .copyWith(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              DateFormat.yMMMd().format(
                                                  DateTime.parse(state
                                                      .list[index].reportDate)),
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.caption
                                                  .copyWith(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w200),
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: [
                                        Divider(
                                          thickness: 1.0,
                                          height: 1.0,
                                        ),
                                        _buildInnerBottomWidget1(vitalVal,
                                            uniqueKey, patientId, theme)
                                      ]),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
            ),
    );
  }

  Widget _buildInnerBottomWidget1(
      List<Test> model, String uniqueKey, int patientId, ThemeData theme) {
    return Builder(builder: (context) {
      return VitalTable(
          vitalTypes: model,
          headers: [
            'Investigation',
            'Result',
            'Units',
            'Bio. Ref. Interval',
            'Trend'
          ],
          patientId: patientId,
          uniqueKey: uniqueKey);
    });
  }

  Widget buildBody(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _vitalVals != null ? _vitalVals.length : 0,
        itemBuilder: (context, index) {
          final VitalVal vitalVal = _vitalVals[index];
          if (vitalVal.vital_value.length > 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTileCard(
                  baseColor: AppColors.grey10,
                  expandedColor: Colors.grey[50],
                  // key: cardA,
                  title: new SizedBox(
                    child: Text(
                      "${vitalVal.vital_label}" + "",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.caption.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  children: [
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    _buildInnerBottomWidget(vitalVal, theme)
                  ]),
            );
          } else if (vitalVal.vital_value.length <= 0 && index == 0) {
            return Container(
                height: SizeConfig.blockSizeVertical * 80,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Report under processing. Please try after some time.'),
                  ),
                ));
          } else if (index == 0) {
            return Container(
                height: SizeConfig.blockSizeVertical * 80,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Report under processing. Please try after some time.'),
                  ),
                ));
          }
        });
  }

  Widget _buildInnerBottomWidget(VitalVal model, ThemeData theme) {
    return Builder(builder: (context) {
      return VitalTable(
          vitalTypes: model.vital_value,
          headers: [
            'Investigation',
            'Result',
            'Units',
            'Bio. Ref. Interval',
            'Trend'
          ],
          patientId: member.family_member.id,
          uniqueKey: model.vital_key);
    });
  }

  void toggle(VitalVal model) {
    final tile =
        _vitalVals.firstWhere((item) => item.vital_key == model.vital_key);

    setState(() => tile.show = !tile.show);
  }
}

class VitalTable extends StatelessWidget {
  const VitalTable(
      {Key key,
      @required this.vitalTypes,
      @required this.headers,
      @required this.patientId,
      @required this.uniqueKey})
      : super(key: key);

  final List<Test> vitalTypes;
  final List<String> headers;
  final int patientId;
  final String uniqueKey;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Sizes.PADDING_8),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.25),
        },
        // defaultColumnWidth: FixedColumnWidth(120.0),
        border: TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.grey, style: BorderStyle.solid),
        ),
        children: buildRows(theme),
      ),
    );
  }

  List<TableRow> buildRows(ThemeData theme) {
    // DateFormat newFormat = DateFormat("yyyy-MM-dd");
    // DateFormat newFormatTime = DateFormat("h:mma");

    List<TableRow> rows = [];

    int id = 0;

    List<Widget> rowChildren = [];

    for (var y = 0; y < headers.length; y++, id++) {
      // fill row with buttons
      rowChildren.add(
        new HeaderRow(header: headers[y]),
      );
    }
    rows.add(new TableRow(children: rowChildren));

    for (var index = 0; index < vitalTypes.length; index++) {
      List<Widget> rowChildren1 = [];
      Test item = vitalTypes[index];

      rowChildren1.add(
        buildRowContainer(text: item.test, theme: theme, item: item),
      );
      rowChildren1.add(
        buildRowContainer(text: item.value, theme: theme, item: item),
      );
      rowChildren1.add(
        buildRowContainer(text: item.unit, theme: theme, item: item),
      );
      rowChildren1.add(
        buildRowContainer(text: item.interval, theme: theme, item: item),
      );
      rowChildren1.add(
        buildRowContainer(
            text: item.unit, theme: theme, isButton: true, item: item),
      );

      rows.add(new TableRow(children: rowChildren1));
    }

    return rows;
  }

  Center buildRowContainer(
      {text, ThemeData theme, bool isButton = false, Test item}) {
    return Center(
      child: isButton
          ? SizedBox(
              width: 50,
              child: RaisedButton(
                color: AppColors.primaryColor,
                hoverColor: AppColors.lightButton,
                onPressed: () {
                  print('unique_key' + item.toJson().toString());
                  // print('uniqueKey' + uniqueKey);
                  ExtendedNavigator.root.push(Routes.trendReport,
                      arguments: TrendReportArguments(
                          test: item.test,
                          uniquekey: item.unique_key != null
                              ? item.unique_key
                              : uniqueKey,
                          patientid: patientId));
                },
                child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                  Icons.bar_chart,
                  color: AppColors.white,
                  size: 20,
                )),
              ),
            )
          : Container(
              padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Text(
                text,
                style: theme.textTheme.caption
                    .copyWith(color: AppColors.tableText),
              ),
            ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key key,
    @required this.header,
  }) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: Sizes.PADDING_10),
        child: Text(header,
            style: theme.textTheme.caption.copyWith(
              color: AppColors.tableText,
              fontWeight: FontWeight.w900,
            )),
      )
    ]);
  }
}
