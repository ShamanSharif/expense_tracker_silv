import 'package:flutter/material.dart';

class ExpenseCategory {
  String docId;
  IconData? iconData;
  String name;
  int spent;
  int remains;

  ExpenseCategory({
    required this.docId,
    required this.name,
    this.spent = 0,
    this.remains = 0,
    this.iconData,
  });
}
