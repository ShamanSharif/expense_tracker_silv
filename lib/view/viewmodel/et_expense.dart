import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ETExpense extends StatelessWidget {
  final ExpenseCategory expense;
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
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFDCF8F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                child: Icon(
                  expense.iconData ?? Icons.star,
                  color: Color(0xFF56ACC4),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              expense.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  "Spent: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  expense.spent.toString() + " BDT",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF057FA6),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Remains: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  expense.remains.toString() + " BDT",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF057FA6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
