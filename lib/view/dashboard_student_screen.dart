import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/add_expense_screen.dart';
import 'package:expense_tracker/view/categories_screen.dart';
import 'package:expense_tracker/view/viewmodel/et_button.dart';
import 'package:expense_tracker/view/viewmodel/et_expense.dart';
import 'package:expense_tracker/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category_expenses.dart';
import 'viewmodel/et_drawer_button.dart';

class DashboardStudentScreen extends StatefulWidget {
  const DashboardStudentScreen({super.key});

  @override
  State<DashboardStudentScreen> createState() => _DashboardStudentScreenState();
}

class _DashboardStudentScreenState extends State<DashboardStudentScreen> {
  final db = FirebaseFirestore.instance;

  String _userID = "";
  var userObject;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          _userID = user.uid;
        });
        _getUserData();
      }
    });
  }

  _getUserData() async {
    final userData = await db.collection("user_data").doc(_userID).get();
    setState(() {
      userObject = userData;
    });
  }

  _showUserModal() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter state) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.red,
                child: Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Color(0xFF3F9DBB),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                userObject["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(userObject["phone"]),
                              const SizedBox(height: 5),
                              Text(userObject["email"]),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ETButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Close"),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: ETButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut().then(
                                              (value) =>
                                                  Navigator.pushAndRemoveUntil(
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
                                      color: Colors.red,
                                      child: Text("Sign Out"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
              _showUserModal();
            },
            child: Row(
              children: [
                Icon(
                  Icons.person_outlined,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text("Student"),
                const SizedBox(
                  width: 20,
                ),
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
                                    return CategoriesScreen(
                                      group: 1,
                                    );
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
                    print(cat.get("name"));
                    String? name = cat.get("name");
                    int alottedAmount = cat.get("alottedAmount");
                    int spentAmount = cat.get("spentAmount");
                    bool? isStarred = cat.get("starred");

                    if (isStarred == null || isStarred == false) continue;
                    if (name == null) continue;
                    final category = ExpenseCategory(
                      docId: cat.id,
                      name: name,
                      alotted: alottedAmount,
                      spent: spentAmount,
                      remains: alottedAmount - spentAmount,
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
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CategoryExpensesScreen(
                                          expenseCategory: e,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ETExpense(expense: e)),
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
