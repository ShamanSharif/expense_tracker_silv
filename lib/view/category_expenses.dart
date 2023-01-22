import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/model/validator_classes.dart';
import 'package:flutter/material.dart';

import 'viewmodel/et_text_field.dart';

class CategoryExpensesScreen extends StatefulWidget {
  final ExpenseCategory expenseCategory;
  const CategoryExpensesScreen({
    super.key,
    required this.expenseCategory,
  });

  @override
  State<CategoryExpensesScreen> createState() => _CategoryExpensesScreenState();
}

class _CategoryExpensesScreenState extends State<CategoryExpensesScreen> {
  final db = FirebaseFirestore.instance;
  late ExpenseCategory expenseCategory;

  @override
  void initState() {
    super.initState();
    expenseCategory = widget.expenseCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8FAF2),
      appBar: AppBar(
        backgroundColor: Color(0xFFE8FAF2),
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(expenseCategory.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alotted:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    expenseCategory.alotted.toString() + " BDT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Spent:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    expenseCategory.spent.toString() + " BDT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Remains:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    expenseCategory.remains.toString() + " BDT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("category")
                    .doc(expenseCategory.docId)
                    .collection("expenses")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final expenses = snapshot.data?.docs;
                    List<Expense> expenseList = [];
                    if (expenses == null) return Text("DB Fetching Error");
                    for (var exp in expenses) {
                      print(exp);
                      String? name = exp.get("name");
                      int? amount = exp.get("amount");
                      String? quantity = exp.get("quantity");
                      String? note = exp.get("note");
                      DateTime? dateTime =
                          exp.get("dateTime").toString().getDateFormatted();
                      if (name == null ||
                          amount == null ||
                          quantity == null ||
                          dateTime == null) continue;
                      final expense = Expense(
                        name: name,
                        amount: amount,
                        quantity: quantity,
                        dateTime: dateTime,
                        note: note,
                      );
                      expenseList.add(expense);
                    }
                    return Expanded(
                      child: ListView(
                        children: [
                          Container(
                            color: Color(0xFF3F9DBB),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Date",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Quantity",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Amount",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for (int i = 0; i < expenseList.length; i++)
                            Container(
                              color:
                                  i.isEven ? Colors.white : Color(0xFFDCF8F6),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        expenseList[i]
                                            .dateTime
                                            .showDateFormatted(),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(expenseList[i].name),
                                    ),
                                    Expanded(
                                      child: Text(
                                        expenseList[i].quantity.toString(),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        expenseList[i].amount.toString(),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
