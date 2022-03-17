import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'constants.dart';

class VitalChart extends StatelessWidget {
  const VitalChart({
    Key key,
    @required this.vitalTypes,
  }) : super(key: key);

  final List<VitalTypeResult> vitalTypes;

  @override
  Widget build(BuildContext context) {
    // print('vitalTypes ======>' + vitalTypes.toString());
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    bool valueCheck =
        vitalTypes[0].value != null && vitalTypes[0].value.contains(',');
    ThemeData theme = Theme.of(context);
    return SfCartesianChart(
      backgroundColor: AppColors.white,
      primaryXAxis: CategoryAxis(
        isVisible: true,
        isInversed: false,
        // labelRotation: 90,
      ),
      //Title
      title: ChartTitle(
          text: Constants.switchName(vitalTypes[0].type),
          textStyle: theme.textTheme.subtitle2),
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
        lineType: CrosshairLineType.horizontal, //Horizontal selection indicator
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
        textStyle:
            theme.textTheme.caption.copyWith(color: AppColors.primaryText),
      ),
      //SplineSeries is a curve LineSeries is a polyline ChartSeries
      series: <ChartSeries<VitalTypeResult, String>>[
        LineSeries<VitalTypeResult, String>(
          color: AppColors.chart2,
          name: (valueCheck)
              ? StringConst.label.Systolic
              : Constants.switchName(vitalTypes[0].type),
          dataSource: vitalTypes,
          xValueMapper: (VitalTypeResult sales, _) =>
              newFormat.format(sales.measureOn),
          yValueMapper: (VitalTypeResult sales, _) => (valueCheck)
              ? int.tryParse(sales.value.split(',')[0].split(':')[1])
              : int.tryParse(sales.value),

          //Display data label
          dataLabelSettings: DataLabelSettings(
            color: AppColors.white,
            isVisible: false,
            alignment: ChartAlignment.near,
            labelAlignment: ChartDataLabelAlignment.outer,
            showCumulativeValues: true,
            textStyle: ChartTextStyle(fontSize: 14, fontFamily: 'Poppins'),
          ),
          //Modify data points (show circles)
          markerSettings: MarkerSettings(
            isVisible: true,
          ),
        ),
        if (vitalTypes[0].value != null && vitalTypes[0].value.contains(','))
          LineSeries<VitalTypeResult, String>(
            name: StringConst.label.Diastrolic,
            color: AppColors.chart1,
            dataSource: vitalTypes,
            xValueMapper: (VitalTypeResult sales, _) =>
                newFormat.format(sales.measureOn),
            yValueMapper: (VitalTypeResult sales, _) => (valueCheck)
                ? int.tryParse(sales.value.split(',')[1].split(':')[1])
                : int.tryParse(sales.value),
            //Display data label
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
            ),
            //Modify data points (show circles)
            markerSettings:
                MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
          ),
      ],
    );
  }
}

class VitalSugarChart extends StatefulWidget {
  const VitalSugarChart({
    Key key,
    @required this.vitalTypes,
  }) : super(key: key);

  final List<VitalTypeResult> vitalTypes;

  @override
  _VitalSugarChartState createState() => _VitalSugarChartState();
}

class SugarType {
  final String measureOn;
  final int valueR;
  final int valueBp;
  final int valueF;

  SugarType({
    this.measureOn,
    this.valueR,
    this.valueBp,
    this.valueF,
  });
}

class SugarRandomType {
  final String measureOn;
  final int value;

  SugarRandomType({
    this.measureOn,
    this.value,
  });
}

class SugarFastingType {
  final String measureOn;
  final int value;

  SugarFastingType({
    this.measureOn,
    this.value,
  });
}

class SugarBpType {
  final String measureOn;
  final int value;

  SugarBpType({
    this.measureOn,
    this.value,
  });
}

class MeasuredOn {
  final String measureOn;

  MeasuredOn({
    this.measureOn,
  });
}

class _VitalSugarChartState extends State<VitalSugarChart> {
  List<SugarType> sugars = [];
  List<SugarRandomType> sugars_random = [];
  List<SugarFastingType> sugars_fasting = [];
  List<SugarBpType> sugars_bp = [];
  List<MeasuredOn> mesuredOns = [];
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.vitalTypes.length; i++) {
      String random;
      String fasting;
      String bp;
      VitalTypeResult mm = widget.vitalTypes[i];

      if (mm.value != null && mm.value.indexOf('Sugar Random') > -1) {
        random = mm.value.replaceAll('Sugar Random:', '').trim();
        if (random != null)
          sugars_random.add(SugarRandomType(
              measureOn: newFormat.format(mm.measureOn),
              value: int.tryParse(random)));
      } else if (mm.value != null && mm.value.indexOf('Sugar Fasting') > -1) {
        fasting = mm.value.replaceAll('Sugar Fasting:', '').trim();
        if (fasting != null)
          sugars_fasting.add(SugarFastingType(
              measureOn: newFormat.format(mm.measureOn),
              value: int.tryParse(fasting)));
      } else if (mm.value != null && mm.value.indexOf('Sugar PP') > -1) {
        bp = mm.value.replaceAll('Sugar PP:', '').trim();
        if (bp != null)
          sugars_bp.add(SugarBpType(
              measureOn: newFormat.format(mm.measureOn),
              value: int.tryParse(bp)));
      } else {
        random = mm.value.trim();
        if (random != null) {
          sugars_random.add(SugarRandomType(
              measureOn: newFormat.format(mm.measureOn),
              value: int.tryParse(random)));
        }
      }
      mesuredOns.add(MeasuredOn(measureOn: newFormat.format(mm.measureOn)));

      // _foodList.where((food) => food.name.toLowerCase().contains(userInputValue.toLowerCase()) || posts

    }
    if (mesuredOns.length > 0) {
      for (var mesured in mesuredOns) {
        print('mesured  =============>  ' + mesured.measureOn);
        SugarRandomType r = !sugars_random.isEmpty
            ? sugars_random
                        .where((ran) => ran.measureOn == mesured.measureOn)
                        .toList()
                        .length >
                    0
                ? sugars_random
                    .where((ran) => ran.measureOn == mesured.measureOn)
                    .toList()[0]
                : null
            : null;
        SugarFastingType f = !sugars_fasting.isEmpty
            ? sugars_fasting
                        .where((ran) => ran.measureOn == mesured.measureOn)
                        .toList()
                        .length >
                    0
                ? sugars_fasting
                    .where((ran) => ran.measureOn == mesured.measureOn)
                    .toList()[0]
                : null
            : null;
        SugarBpType bp = !sugars_bp.isEmpty
            ? sugars_bp
                        .where((ran) => ran.measureOn == mesured.measureOn)
                        .toList()
                        .length >
                    0
                ? sugars_bp
                    .where((ran) => ran.measureOn == mesured.measureOn)
                    .toList()[0]
                : null
            : null;
        sugars.add(SugarType(
            valueR: (r != null) ? r.value : 0,
            valueF: (f != null) ? f.value : 0,
            valueBp: (bp != null) ? bp : 0,
            measureOn: mesured.measureOn));
      }
    }
    setState(() {
      sugars = sugars.length>4?sugars.take(4).toList():sugars.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SfCartesianChart(
      backgroundColor: AppColors.white,
      primaryXAxis: CategoryAxis(
        isVisible: true,
        isInversed: false,
        // labelRotation: 90,
      ),
      //Title
      title: ChartTitle(
          text: Constants.switchName(widget.vitalTypes[0].type),
          textStyle: theme.textTheme.subtitle2),
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
        lineType: CrosshairLineType.horizontal, //Horizontal selection indicator
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
        textStyle:
            theme.textTheme.caption.copyWith(color: AppColors.primaryText),
      ),
      //SplineSeries is a curve LineSeries is a polyline ChartSeries
      series: <ChartSeries<SugarType, String>>[
        LineSeries<SugarType, String>(
          color: AppColors.chart2,
          name: StringConst.label.Random,
          dataSource: sugars,
          xValueMapper: (SugarType sales, _) => sales.measureOn,
          yValueMapper: (SugarType sales, _) => sales.valueR,

          //Display data label
          dataLabelSettings: DataLabelSettings(
            color: AppColors.white,
            isVisible: false,
            alignment: ChartAlignment.near,
            labelAlignment: ChartDataLabelAlignment.outer,
            showCumulativeValues: true,
            textStyle: ChartTextStyle(fontSize: 14, fontFamily: 'Poppins'),
          ),
          //Modify data points (show circles)
          markerSettings: MarkerSettings(
            isVisible: true,
          ),
        ),
        LineSeries<SugarType, String>(
          name: StringConst.label.Fasting,
          color: AppColors.chart1,
          dataSource: sugars,
          xValueMapper: (SugarType sales, _) => sales.measureOn,
          yValueMapper: (SugarType sales, _) => sales.valueF,
          //Display data label
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
          ),
          //Modify data points (show circles)
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
        ),
        LineSeries<SugarType, String>(
          name: StringConst.label.Bp,
          color: AppColors.lightButton,
          dataSource: sugars,
          xValueMapper: (SugarType sales, _) => sales.measureOn,
          yValueMapper: (SugarType sales, _) => sales.valueBp,
          //Display data label
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
          ),
          //Modify data points (show circles)
          markerSettings:
              MarkerSettings(isVisible: true, shape: DataMarkerType.diamond),
        ),
      ],
    );
  }
}
