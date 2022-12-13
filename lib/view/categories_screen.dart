import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<ExpenseCategory> expenses = [
    ExpenseCategory(
      iconData: Icons.monitor,
      name: "Hardware",
      spent: 20220,
      remains: 1135,
    ),
    ExpenseCategory(
      iconData: Icons.book,
      name: "Study Material",
      spent: 7899,
      remains: 1135,
    ),
    ExpenseCategory(
      iconData: Icons.bus_alert,
      name: "Transport",
      spent: 14889,
      remains: 1135,
    ),
    ExpenseCategory(
      iconData: Icons.local_pizza,
      name: "Food",
      spent: 12000,
      remains: 1135,
    ),
    ExpenseCategory(
      iconData: Icons.school,
      name: "Club Fund",
      spent: 15970,
      remains: 1135,
    ),
    ExpenseCategory(
      iconData: Icons.place,
      name: "Recreation",
      spent: 25000,
      remains: 1135,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8FAF2),
      appBar: AppBar(
        backgroundColor: Color(0xFFE8FAF2),
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text("Manage Categories"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              for (ExpenseCategory e in expenses)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(e.iconData ?? Icons.star),
                        SizedBox(width: 20),
                        Text(e.name),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
