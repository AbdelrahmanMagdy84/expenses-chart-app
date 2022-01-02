import 'package:expenses_chart_app/transaction_model.dart';
import 'package:flutter/material.dart';
import 'transaction_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class TransactionsChart extends StatelessWidget {
  final List<Transaction> data;
  TransactionsChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Transaction, DateTime>> series = [
      charts.Series(
        id: "bar chart",
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (Transaction series, _) => series.date,
        measureFn: (Transaction series, _) => series.amount,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      animationDuration: const Duration(seconds: 1),
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      defaultInteractions: false,
      behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
    );
  }
}
