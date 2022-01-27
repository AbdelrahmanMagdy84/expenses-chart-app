import 'package:flutter/cupertino.dart';
import 'package:device_preview/device_preview.dart';
import 'package:expenses_chart_app/widgets/newTransaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import './screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ExpensesApp(), // Wrap your app
    ),
  );
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
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

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      appBar = CupertinoNavigationBar(
        middle: Text('Expenses App'),
        trailing: GestureDetector(
          child: Icon(
            CupertinoIcons.add,
          ),
          onTap: () {
            startAddNewTransaction(context);
          },
        ),
      );
    } else {
      appBar = AppBar(
        title: const Text('Expenses App'),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      );
    }
    Widget pageBody = SafeArea(
      child: transactions.isEmpty
          ? Center(
              child: Text(
                'Press + start adding your expenses',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          : HomeScreen(
              transactions,
              deleteTransaction,
              appBar.preferredSize.height,
            ),
    );

    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton:
                TargetPlatform.iOS == Theme.of(context).platform
                    ? Container()
                    : FloatingActionButton(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
