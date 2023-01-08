class ExpenseCategory {
  String docId;
  bool isStarred;
  String name;
  int spent;
  int remains;

  ExpenseCategory({
    required this.docId,
    required this.name,
    this.spent = 0,
    this.remains = 0,
    this.isStarred = false,
  });
}
