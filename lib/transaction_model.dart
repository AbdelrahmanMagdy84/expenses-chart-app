class Transaction {
  DateTime date;
  String id;
  double amount;
  String title;
  Transaction(
      {required this.id,
      required this.amount,
      required this.title,
      required this.date});
}
