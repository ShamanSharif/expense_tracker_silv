import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/add_expense_screen.dart';
import 'package:expense_tracker/view/categories_screen.dart';
import 'package:expense_tracker/view/viewmodel/et_expense.dart';
import 'package:expense_tracker/view/viewmodel/et_text_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Expense> expenses = [
    Expense(
      iconData: Icons.monitor,
      name: "Hardware",
      amount: 20220,
    ),
    Expense(
      iconData: Icons.book,
      name: "Study Material",
      amount: 7899,
    ),
    Expense(
      iconData: Icons.bus_alert,
      name: "Transport",
      amount: 14889,
    ),
    Expense(
      iconData: Icons.local_pizza,
      name: "Food",
      amount: 12000,
    ),
    Expense(
      iconData: Icons.school,
      name: "Club Fund",
      amount: 15970,
    ),
    Expense(
      iconData: Icons.place,
      name: "Recreation",
      amount: 25000,
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
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_outlined,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ETTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CategoriesScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Categories"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alloted amount",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "1,50,000 BDT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Remains",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "1,00,000 BDT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                height: 30,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Expense Branch",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            for (Expense e in expenses)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20,
                ),
                child: ETExpense(expense: e),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddExpenseScreen();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
