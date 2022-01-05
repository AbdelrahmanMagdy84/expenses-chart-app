import 'package:expenses_chart_app/models/transaction_model.dart';
import 'package:expenses_chart_app/widgets/transactions_chart.dart';
import 'package:expenses_chart_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  List<Transaction> trasnactions;
  Function deleteTransaction;

  HomeScreen(this.trasnactions, this.deleteTransaction);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TransactionsChart(
            Transaction.generateChartTransactions(widget.trasnactions)),
        SizedBox(
          height: 10,
        ),
        TransactionsList(widget.trasnactions, widget.deleteTransaction)
      ]),
    );
  }
}
