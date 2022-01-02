import './transaction_model.dart';
import 'package:flutter/material.dart';
import './List_item_widget.dart';
import './transactions_chart.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatefulWidget {
  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: new DateTime(2021, 12, 3),
    ),
    Transaction(
      id: 't1',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: new DateTime(2021, 12, 3),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 50.53,
      date: new DateTime(2021, 12, 4),
    ),
    Transaction(
      id: 't3',
      title: 'Weekly Groceries',
      amount: 50.53,
      date: new DateTime(2021, 12, 9),
    ),
    Transaction(
      id: 't4',
      title: 'Weekly Groceries',
      amount: 50.53,
      date: new DateTime(2021, 12, 6),
    ),
    Transaction(
      id: 't5',
      title: 'Weekly Groceries',
      amount: 50.53,
      date: new DateTime(2021, 12, 9),
    ),
  ];

  List<Transaction> sortedTransactions(List<Transaction> tr) {
    List<Transaction> copy = [];
    copy.addAll(tr);
    int i = 0, j = i + 1;
    while (j < copy.length) {
      if (copy[i].date.day == copy[j].date.day) {
        copy[i].amount += copy[j].amount;
        copy.removeAt(j);
      } else {
        i++;
        j++;
      }
    }
    List<Transaction> result = [];
    copy.sort((a, b) => a.date.compareTo(b.date));
    result.addAll(copy);
    return result;
  }

  void AddingTransaction(
      {required List<Transaction> trans,
      required DateTime date,
      required String id,
      required double amount,
      required String title}) {
    setState(() {
      trans.add(
          new Transaction(amount: amount, id: id, title: title, date: date));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.brown[100]),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          title: const Text('Expenses App'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                width: double.infinity,
                height: 300,
                child: Flex(
                  children: [
                    Expanded(
                      child: TransactionsChart(
                        sortedTransactions(transactions),
                      ),
                    ),
                  ],
                  direction: Axis.horizontal,
                )),
            SizedBox(
              height: 10,
            ),
            ...transactions.map((e) {
              return ListItemWidget(e);
            }).toList()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.brown[100],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
