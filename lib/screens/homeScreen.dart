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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: Colors.brown[100],
          flexibleSpace: FlexibleSpaceBar(
            background: TransactionsChart(
              Transaction.generateChartTransactions(widget.trasnactions),
            ),
            centerTitle: true,
            title: Text("Expenses"),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          TransactionsList(widget.trasnactions, widget.deleteTransaction),
          SizedBox(
            height: 70,
          ),
        ]))
      ],
    );
  }
}
