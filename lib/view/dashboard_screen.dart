import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/add_expense_screen.dart';
import 'package:expense_tracker/view/categories_screen.dart';
import 'package:expense_tracker/view/viewmodel/et_expense.dart';
import 'package:expense_tracker/view/viewmodel/et_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'viewmodel/et_drawer_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _useremail = "";
  List<ExpenseCategory> expenses = [
    ExpenseCategory(
      iconData: Icons.monitor,
      name: "Hardware",
      spent: 20220,
      remains: 654,
    ),
    ExpenseCategory(
      iconData: Icons.book,
      name: "Study Material",
      spent: 7899,
      remains: 6541,
    ),
    ExpenseCategory(
      iconData: Icons.bus_alert,
      name: "Transport",
      spent: 14889,
      remains: 3654,
    ),
    ExpenseCategory(
      iconData: Icons.local_pizza,
      name: "Food",
      spent: 12000,
      remains: 1654,
    ),
    ExpenseCategory(
      iconData: Icons.school,
      name: "Club Fund",
      spent: 15970,
      remains: 5654,
    ),
    ExpenseCategory(
      iconData: Icons.place,
      name: "Recreation",
      spent: 25000,
      remains: 21000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          _useremail = user.email!;
        });
      }
    });
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
        title: Text("Expense Tracker"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.person_outlined,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(_useremail),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFE8FAF2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset("assets/images/drawer_banner.png"),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Expense Tracker",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20),
                          ETDrawerButton(
                            label: 'Home',
                            iconData: Icons.home,
                            onPressed: () {},
                          ),
                          ETDrawerButton(
                            label: 'Calender',
                            iconData: Icons.calendar_month,
                            onPressed: () {},
                          ),
                          ETDrawerButton(
                            label: 'Catgory',
                            iconData: Icons.list,
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
                          ),
                          ETDrawerButton(
                            label: 'Settings',
                            iconData: Icons.settings,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Expense Tracker is built with ❤️️ by \n'Sadia Islam Silvee'",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
                      color: Color(0xFF057FA6),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "1,50,000 BDT",
                    style: TextStyle(
                      color: Color(0xFF057FA6),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Remains",
                    style: TextStyle(
                      color: Color(0xFF057FA6),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "1,00,000 BDT",
                    style: TextStyle(
                      color: Color(0xFF057FA6),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
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
                  // fontFamily: "BebasNeue",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            for (ExpenseCategory e in expenses)
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
