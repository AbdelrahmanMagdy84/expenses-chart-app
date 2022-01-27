import 'package:expenses_chart_app/widgets/newTransaction.dart';
import './screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.brown[100],
        primarySwatch: Colors.brown,
      ),
      home: buildScafold(),
    );
  }
}

class buildScafold extends StatefulWidget {
  @override
  State<buildScafold> createState() => _buildScafoldState();
}

class _buildScafoldState extends State<buildScafold> {
  List<Transaction> transactions = [];

  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime pdate = DateTime.now();
  bool datePickerOpend = false;

  void addingTransaction(
      {required List<Transaction> trans,
      required int id,
      required double amount,
      required String title,
      required DateTime date}) {
    setState(() {
      trans.add(
          new Transaction(amount: amount, id: id, title: title, date: date));
      amountController = new TextEditingController();
      titleController = new TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: transactions.isEmpty
          ? Center(
              child: Text('Press + start adding your expenses'),
            )
          : HomeScreen(transactions, deleteTransaction),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
                onPressed: () {
                  startAddNewTransaction(
                    context,
                  );
                },
                backgroundColor: Colors.brown[100],
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void startAddNewTransaction(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(
            transactions: transactions,
            addNewTransaction: addingTransaction,
            amountController: amountController,
            titleController: titleController,
          );
        });
  }

  void deleteTransaction(Transaction deletingTransaction) {
    setState(() {
      transactions.remove(deletingTransaction);
    });
  }
}
