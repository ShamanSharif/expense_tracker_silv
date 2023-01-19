import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/add_expense_screen.dart';
import 'package:expense_tracker/view/categories_screen.dart';
import 'package:expense_tracker/view/viewmodel/et_expense.dart';
import 'package:expense_tracker/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'viewmodel/et_drawer_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final db = FirebaseFirestore.instance;

  String _useremail = "";
  List<ExpenseCategory> expenses = [
    // TODO: Fetch From DB
  ];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          _useremail = user.displayName ?? "";
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
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Double Tap to Sign Out"),
                ),
              );
            },
            onDoubleTap: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeScreen();
                        },
                      ),
                      (route) => false,
                    ),
                  );
            },
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
            StreamBuilder<QuerySnapshot>(
              stream: db.collection("category").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final categories = snapshot.data?.docs;
                  List<ExpenseCategory> categoriesList = [];
                  if (categories == null) return Text("DB Fetching Error");
                  for (var cat in categories) {
                    String? name = cat.get("name");
                    bool? isStarred = cat.get("starred");
                    if (isStarred == null || isStarred == false) continue;
                    if (name == null) continue;
                    final category = ExpenseCategory(
                      docId: cat.id,
                      name: name,
                      isStarred: isStarred,
                    );
                    categoriesList.add(category);
                  }
                  return Expanded(
                    child: ListView(
                      children: [
                        for (ExpenseCategory e in categoriesList)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            child: ETExpense(expense: e),
                          ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Icon(e.isStarred
                        //             ? Icons.star
                        //             : Icons.star_border),
                        //         SizedBox(width: 20),
                        //         Text(e.name),
                        //       ],
                        //     ),
                        //     Icon(Icons.edit),
                        //   ],
                        // ),
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
