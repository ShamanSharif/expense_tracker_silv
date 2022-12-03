import 'package:flutter/material.dart';

class Expense {
  IconData? iconData;
  String name;
  int amount;

  Expense({
    required this.name,
    this.amount = 0,
    this.iconData,
  });
}
