import 'package:flutter/material.dart';

class ExpenseCategory {
  IconData? iconData;
  String name;
  int amount;

  ExpenseCategory({
    required this.name,
    this.amount = 0,
    this.iconData,
  });
}
