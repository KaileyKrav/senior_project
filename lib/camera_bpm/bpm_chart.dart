import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BPMChart extends StatelessWidget {
  final List<SensorValue> _data;

  BPMChart(this._data);

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart([
      charts.Series<SensorValue, DateTime>(
        id: 'Values',
        colorFn: (_,__) => charts.ColorUtil.fromDartColor(Colors.cyan),
        domainFn: (SensorValue values, _) => values.time,
        measureFn: (SensorValue values, _) => values.value,
        data: _data,
      ),
    ],
      animate: false,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
          charts.BasicNumericTickProviderSpec(zeroBound: false),
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: new charts.DateTimeAxisSpec(
        renderSpec: new charts.NoneRenderSpec()));
  }
}

class SensorValue {
  final DateTime time;
  final double value;

  SensorValue(this.time, this.value);
}