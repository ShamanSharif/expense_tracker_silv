import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ETExpense extends StatelessWidget {
  final Expense expense;
  const ETExpense({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(expense.iconData ?? Icons.star),
            SizedBox(width: 20),
            Text(expense.name),
          ],
        ),
        Text(expense.amount.toString() + " BDT"),
      ],
    );
  }
}
