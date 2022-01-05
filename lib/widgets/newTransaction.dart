import 'package:expenses_chart_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addNewTransaction;
  List<Transaction> transactions;
  var titleController;
  var amountController;
  NewTransaction(
      {required this.transactions,
      required this.addNewTransaction,
      required this.titleController,
      required this.amountController});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime pdate = DateTime.now();

  bool datePickerOpend = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: widget.titleController,
                autofocus: false,
                decoration: InputDecoration(label: Text('Title')),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: widget.amountController,
                autofocus: false,
                keyboardType: TextInputType.number,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  label: const Text("Amount"),
                ),
              ),
              datePickerOpend == false
                  ? TextButton(
                      onPressed: () {
                        displayDatePicker(context);
                      },
                      child: const Text('Select date '))
                  : Text(
                      DateFormat.yMMMd().format(pdate),
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                child: const Text('Submit'),
                onPressed: () {
                  final String newTitle = widget.titleController.text;
                  final double newAmount =
                      double.parse(widget.amountController.text);
                  if (newTitle.isEmpty || newAmount <= 0) {
                    return;
                  }
                  widget.addNewTransaction(
                      trans: widget.transactions,
                      id: Transaction.getNewId(),
                      amount: newAmount,
                      title: newTitle,
                      date: pdate);

                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void displayDatePicker(context) {
    FocusScope.of(context).requestFocus(FocusNode());

    showDatePicker(
      context: context,
      initialDate: pdate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),

      //initialDatePickerMode: DatePickerMode.day
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          pdate = pickedDate;
        });
      }
    });
  }
}
