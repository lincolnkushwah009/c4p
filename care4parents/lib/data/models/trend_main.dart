class TrendMain {
  String confirmation;
  Trend data;

  TrendMain({this.confirmation, this.data});

  TrendMain.fromJson(Map<String, dynamic> json) {
    confirmation = json['confirmation'];
    data = json['data'] != null ? new Trend.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmation'] = this.confirmation;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Trend {
  String uniqueKey;
  List<String> tests;
  List<String> dates;
  List<String> values;
  List<String> units;
  List<String> intervals;

  Trend(
      {this.uniqueKey,
      this.tests,
      this.dates,
      this.values,
      this.units,
      this.intervals});

  Trend.fromJson(Map<String, dynamic> json) {
    uniqueKey = json['unique_key'];
    tests = json['Tests'].cast<String>();
    dates = json['Dates'].cast<String>();
    values = json['Values'].cast<String>();
    units = json['Units'].cast<String>();
    intervals = json['Intervals'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_key'] = this.uniqueKey;
    data['Tests'] = this.tests;
    data['Dates'] = this.dates;
    data['Values'] = this.values;
    data['Units'] = this.units;
    data['Intervals'] = this.intervals;
    return data;
  }
}
