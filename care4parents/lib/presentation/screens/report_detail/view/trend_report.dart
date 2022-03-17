import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/trend_main.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// import 'constants.dart';

class TrendReport extends StatefulWidget {
  const TrendReport({Key key, this.test, this.uniquekey, this.patientid})
      : super(key: key);
  final String uniquekey;
  final String test;
  final int patientid;

  @override
  _TrendReportState createState() =>
      _TrendReportState(this.test, this.uniquekey, this.patientid);
}

class _TrendReportState extends State<TrendReport> {
  OtherCubit _otherCubit;
  String _unique_key;
  String _test;
  int _patient_id;
  _TrendReportState(String test, String unique_key, int patient_id) {
    this._test = test;
    this._unique_key = unique_key;
    this._patient_id = patient_id;
  }

  @override
  void initState() {
    super.initState();
    _otherCubit = getItInstance<OtherCubit>();
    _otherCubit.getTrendReport(_unique_key, _patient_id);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);

    ThemeData theme = Theme.of(context);
    // print('_test ======='+_test)
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _otherCubit,
        )
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
          child: CustomAppBar(
              title: StringConst.REPORT_DETAIL,
              // onLeadingTap: () => _openDrawer(),
              leading: InkWell(
                  onTap: () => ExtendedNavigator.root.pop(),
                  child: Icon(Icons.arrow_back_ios_outlined)),
              trailing: [

                new whatappIconwidget(isHeader:true)
              ],
              hasTrailing: true),
        ),
        body: Center(
          child: BgCard(
            padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
            width: widthOfScreen * 0.9,
            height: heightOfScreen * 0.5,
            borderRadius: const BorderRadius.all(
              const Radius.circular(Sizes.RADIUS_24),
            ),
            child: BlocBuilder<OtherCubit, OtherState>(
              builder: (context, state) {
                if (state is OtherInitial) {
                  return AppLoading();
                } else if (state is Loading) {
                  return AppLoading();
                } else if (state is LoadedTrend) {
                  return SfCartesianChart(
                    backgroundColor: AppColors.white,
                    primaryXAxis: CategoryAxis(
                      isVisible: true,
                      isInversed: false,
                      // labelRotation: 90,
                    ),
                    //Title
                    title: ChartTitle(
                        text: _test, textStyle: theme.textTheme.subtitle2),
                    //Selected type
                    selectionType: SelectionType.series,
                    //Time axis and value axis transposition
                    isTransposed: false,
                    //Select gesture
                    selectionGesture: ActivationMode.singleTap,
                    //Illustration
                    legend: Legend(
                        isVisible: true,
                        iconHeight: 10,
                        iconWidth: 10,
                        //Switch series display
                        toggleSeriesVisibility: true,
                        //Illustration display position
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        //Illustration left and right position
                        alignment: ChartAlignment.center),
                    //Cross
                    crosshairBehavior: CrosshairBehavior(
                      lineType: CrosshairLineType
                          .horizontal, //Horizontal selection indicator
                      enable: true,
                      shouldAlwaysShow:
                          false, //The cross is always displayed (horizontal selection indicator)
                      activationMode: ActivationMode.singleTap,
                    ),
                    //Track the ball
                    // Open tooltip
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      shared: true,
                      activationMode: ActivationMode.singleTap,
                      color: AppColors.white,
                      textStyle: theme.textTheme.caption
                          .copyWith(color: AppColors.primaryText),
                    ),
                    //SplineSeries is a curve LineSeries is a polyline ChartSeries
                    series: <ChartSeries<Report, String>>[
                      LineSeries<Report, String>(
                        color: AppColors.chart2,
                        name: _test,
                        dataSource: state.list,
                        xValueMapper: (Report sales, _) => sales.date,
                        yValueMapper: (Report sales, _) =>
                            double.parse(sales.value),

                        //Display data label
                        dataLabelSettings: DataLabelSettings(
                          color: AppColors.white,
                          isVisible: false,
                          alignment: ChartAlignment.near,
                          labelAlignment: ChartDataLabelAlignment.outer,
                          showCumulativeValues: true,
                          textStyle: ChartTextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                        ),
                        //Modify data points (show circles)
                        markerSettings: MarkerSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(child: Center(child: Text('No data found')));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
