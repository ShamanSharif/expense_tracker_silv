class ExpenseCategory {
  String docId;
  bool isStarred;
  String name;
  int alotted;
  int spent;
  int remains;

  ExpenseCategory({
    required this.docId,
    required this.name,
    this.alotted = 0,
    this.spent = 0,
    this.remains = 0,
    this.isStarred = false,
  });

  @override
  String toString() {
    return name;
  }
}

class Expense {
  int amount;
  int quantity;
  String name;
  String dateTime;
  String? note;

  Expense({
    required this.name,
    required this.amount,
    required this.dateTime,
    this.quantity = 1,
    this.note,
  });
}
