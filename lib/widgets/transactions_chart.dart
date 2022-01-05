import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TransactionsChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  TransactionsChart(this.data);

  List<charts.Series<Map<String, dynamic>, DateTime>> generateSeries(
      List<Map<String, dynamic>> transactions) {
    List<charts.Series<Map<String, dynamic>, DateTime>> series = [
      charts.Series(
        id: "bar chart",
        data: transactions,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (Map<String, dynamic> series, _) => series['date'],
        measureFn: (Map<String, dynamic> series, _) => series['amount'],
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: Flex(
          children: [
            Expanded(
                child: charts.TimeSeriesChart(
              generateSeries(data),
              animate: true,
              animationDuration: const Duration(seconds: 1),
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              defaultInteractions: false,
              behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
            )),
          ],
          direction: Axis.horizontal,
        ));
    ;
  }
}
