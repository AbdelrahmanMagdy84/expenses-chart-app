import '../models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItemWidget extends StatelessWidget {
  Function deleteTransaction;
  Transaction currentTransaction;
  ListItemWidget(this.currentTransaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Card(
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.red[200],
                width: double.infinity,
                child: Text(
                  currentTransaction.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              // height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.attach_money),
                      Container(
                        width: 55,
                        child: Text(
                          currentTransaction.amount.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      DateFormat.yMMMd().format(currentTransaction.date),
                    ),
                  ),
                  MediaQuery.of(context).size.width > 340
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTransaction(currentTransaction);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: const FittedBox(
                            child: Text("Delete"),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).errorColor)),
                        )
                      : IconButton(
                          onPressed: () {
                            deleteTransaction(currentTransaction);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
