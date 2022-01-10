import 'package:expenses_chart_app/models/transaction_model.dart';
import 'package:expenses_chart_app/widgets/transactions_chart.dart';
import 'package:expenses_chart_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  List<Transaction> trasnactions;
  Function deleteTransaction;
  var appBareHeight;
  HomeScreen(this.trasnactions, this.deleteTransaction, this.appBareHeight);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var reservedHeight = (mediaQuery.size.height -
        widget.appBareHeight -
        mediaQuery.padding.top);
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: reservedHeight * 0.2,
          child: TransactionsChart(
            Transaction.generateChartTransactions(widget.trasnactions),
          ),
        ),
        SizedBox(
          height: reservedHeight * 0.76,
          child:
              TransactionsList(widget.trasnactions, widget.deleteTransaction),
        )
      ]),
    );
  }
}
