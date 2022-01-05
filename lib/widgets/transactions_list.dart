import '../models/transaction_model.dart';
import 'package:flutter/material.dart';
import './List_item_widget.dart';

class TransactionsList extends StatelessWidget {
  Function deleteTransaction;
  final List<Transaction> transactions;
  TransactionsList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...transactions.map((e) {
          return ListItemWidget(e, deleteTransaction);
        }).toList()
      ],
    );
  }
}
