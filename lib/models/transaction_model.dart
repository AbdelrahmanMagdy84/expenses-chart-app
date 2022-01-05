class Transaction {
  static int _idCounter = 0;
  DateTime date;
  int id;
  double amount;
  String title;
  Transaction(
      {required this.id,
      required this.amount,
      required this.title,
      required this.date});

  static int getNewId() {
    return _idCounter++;
  }

  static List<Map<String, dynamic>> generateChartTransactions(
      List<Transaction> transactions) {
    List<Transaction> copy = [];
    copy.addAll(transactions);
    copy = sortedTransactions(copy);

    List<Map<String, dynamic>> result = List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double weekdayAmount = 0;
      for (int i = 0; i < copy.length; i++) {
        if (copy[i].date.day == weekday.day &&
            copy[i].date.month == weekday.month &&
            copy[i].date.year == weekday.year) {
          weekdayAmount = weekdayAmount + copy[i].amount;
        }
      }

      return {"amount": weekdayAmount, "date": weekday};
    });

    return result;
    //int i = 0, j = i + 1;
    // while (j < copy.length) {
    //   if (copy[i].date.day == copy[j].date.day) {
    //     copy[i].amount += copy[j].amount;
    //     copy.removeAt(j);
    //   } else {
    //     i++;
    //     j++;
    //   }
    // }
  }

  static List<Transaction> sortedTransactions(List<Transaction> transactions) {
    List<Transaction> result = [];
    transactions.sort((a, b) => a.date.compareTo(b.date));
    result.addAll(transactions);
    return result;
  }
}
