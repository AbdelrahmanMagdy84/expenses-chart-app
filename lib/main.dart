import 'package:expenses_chart_app/widgets/newTransaction.dart';
import 'package:flutter/services.dart';
import './screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      home: BuildScafold(),
    );
  }
}

class BuildScafold extends StatefulWidget {
  @override
  State<BuildScafold> createState() => _BuildScafoldState();
}

class _BuildScafoldState extends State<BuildScafold> {
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
      trans.add(Transaction(amount: amount, id: id, title: title, date: date));
      amountController = TextEditingController();
      titleController = TextEditingController();
    });
  }

  var appBar = AppBar(
    title: const Text('Expenses App'),
    backgroundColor: Colors.brown[100],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: transactions.isEmpty
          ? const Center(
              child: Text('Press + start adding your expenses'),
            )
          : HomeScreen(
              transactions, deleteTransaction, appBar.preferredSize.height),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(
            context,
          );
        },
        backgroundColor: Colors.brown[100],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void startAddNewTransaction(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
