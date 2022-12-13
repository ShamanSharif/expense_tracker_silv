import 'package:flutter/material.dart';

class ExpenseCategory {
  IconData? iconData;
  String name;
  int spent;
  int remains;

  ExpenseCategory({
    required this.name,
    this.spent = 0,
    this.remains = 0,
    this.iconData,
  });
}
