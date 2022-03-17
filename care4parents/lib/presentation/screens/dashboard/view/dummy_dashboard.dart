import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DummyDashbord extends StatelessWidget {
  const DummyDashbord({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    ThemeData theme = Theme.of(context);

    String chart1 = 'Hypertension - Rural & Urban India';
    String chart2 = 'Death from Hypertension';
    String chart3 =
        'Prelenece of Hypertension among adults aged 18 and Over, and sex and age: India, 2015-2016';
    List<ChartData> chartData = [
      ChartData('0', 28.8, 14.5),
      ChartData('1', 34.5, 31.7),
      ChartData('2', 35.8, 18.1),
      ChartData('3', 31.8, 21.1)
    ];
    List<ChartData> chartData2 = [
      ChartData('Stoke', 57, 70, pointColor: AppColors.chart2),
      ChartData('Coronary Heart Disease', 24, 29.6,
          pointColor: AppColors.chart1),
    ];
    List<ChartData> c1 = [
      ChartData('Total', 29, 70),
      ChartData('Men', 30, 70),
      ChartData('Women', 27, 70),
    ];
    List<ChartData> c2 = [
      ChartData('Total', 7, 70),
      ChartData('Men', 9, 70),
      ChartData('Women', 5, 70),
    ];
    List<ChartData> c3 = [
      ChartData('Total', 33, 70),
      ChartData('Men', 37, 70),
      ChartData('Women', 29, 70),
    ];
    List<ChartData> c4 = [
      ChartData('Total', 63, 70),
      ChartData('Men', 58, 70),
      ChartData('Women', 66, 70),
    ];

    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpaceH12(),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(chart1, style: theme.textTheme.headline6),
          ),
        ),
        BgCard(
          padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
          width: widthOfScreen * 0.9,
          height: heightOfScreen * 0.5,
          borderRadius: const BorderRadius.all(
            const Radius.circular(Sizes.RADIUS_24),
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
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
            tooltipBehavior: TooltipBehavior(
              enable: true,
              shared: true,
              activationMode: ActivationMode.singleTap,
              color: AppColors.white,
              textStyle: theme.textTheme.caption
                  .copyWith(color: AppColors.primaryText),
            ),
            series: <ChartSeries>[
              StackedColumnSeries<ChartData, String>(
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: theme.textTheme.caption
                          .copyWith(color: AppColors.white),
                      // showCumulativeValues: true,
                      useSeriesColor: true),
                  dataSource: chartData,
                  color: AppColors.primaryColor,
                  name: 'Urban',
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y1),
              StackedColumnSeries<ChartData, String>(
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: theme.textTheme.caption
                          .copyWith(color: AppColors.white),
                      // showCumulativeValues: true,
                      useSeriesColor: true),
                  dataSource: chartData,
                  name: 'Rural',
                  color: AppColors.lightButton,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y2),
            ],
          ),
        ),

        // half circle chart
        SpaceH12(),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(chart2, style: theme.textTheme.headline6),
          ),
        ),
        BgCard(
          padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
          width: widthOfScreen * 0.9,
          height: heightOfScreen * 0.4,
          borderRadius: const BorderRadius.all(
            const Radius.circular(Sizes.RADIUS_24),
          ),
          child: SfCircularChart(
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
            tooltipBehavior: TooltipBehavior(
              enable: true,
              shared: true,
              activationMode: ActivationMode.singleTap,
              color: AppColors.white,
              textStyle: theme.textTheme.caption
                  .copyWith(color: AppColors.primaryText),
            ),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                  dataSource: chartData2,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: theme.textTheme.caption
                          .copyWith(color: AppColors.white),
                      // showCumulativeValues: true,
                      useSeriesColor: true),
                  name: 'Deaths -',
                  pointColorMapper: (ChartData data, _) => data.pointColor,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1,
                  startAngle: 270, // Starting angle of doughnut
                  endAngle: 90 // Ending angle of doughnut
                  )
            ],
          ),
        ),
        //
        SpaceH12(),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(chart3, style: theme.textTheme.headline6),
          ),
        ),
        BgCard(
          padding: EdgeInsets.symmetric(vertical: Sizes.PADDING_16),
          width: widthOfScreen * 0.9,
          height: heightOfScreen * 0.5,
          borderRadius: const BorderRadius.all(
            const Radius.circular(Sizes.RADIUS_24),
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
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
            tooltipBehavior: TooltipBehavior(
              enable: true,
              shared: true,
              activationMode: ActivationMode.singleTap,
              color: AppColors.white,
              textStyle: theme.textTheme.caption
                  .copyWith(color: AppColors.primaryText),
            ),
            series: <ChartSeries>[
              ColumnSeries<ChartData, String>(
                  dataSource: c1,
                  name: '18 and below',
                  color: AppColors.chart2,
                  spacing: 0.2,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y1),
              ColumnSeries<ChartData, String>(
                  dataSource: c2,
                  name: '18-39',
                  spacing: 0.2,
                  color: AppColors.chart1,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y1),
              ColumnSeries<ChartData, String>(
                  dataSource: c3,
                  name: '40-49',
                  spacing: 0.2,
                  color: AppColors.primaryColor,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y1),
              ColumnSeries<ChartData, String>(
                  dataSource: c4,
                  spacing: 0.2,
                  name: '60 - over',
                  color: AppColors.lightButton,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y1)
            ],
          ),
        ),
        SpaceH12()
      ],
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, {this.pointColor});
  final String x;
  final double y1;
  final double y2;
  final Color pointColor;
}
