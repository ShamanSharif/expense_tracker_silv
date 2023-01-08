import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

import 'viewmodel/et_text_field.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _keyOne = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  List<ExpenseCategory> expenseCategories = [];

  String? categoryName;

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
            onPressed: () {
              _showAddCategoryModal();
            },
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
              StreamBuilder<QuerySnapshot>(
                stream: db.collection("category").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final categories = snapshot.data?.docs;
                    List<ExpenseCategory> categoriesList = [];
                    if (categories == null) return Text("DB Fetching Error");
                    for (var cat in categories) {
                      String name = cat.get("name");
                      final category = ExpenseCategory(
                        name: name,
                      );
                      categoriesList.add(category);
                    }
                    return Expanded(
                      child: ListView(
                        children: [
                          for (ExpenseCategory e in categoriesList)
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
                                  onPressed: () {
                                    _showEditCategoryModal(e);
                                  },
                                  icon: Icon(Icons.edit),
                                )
                              ],
                            ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Slow Retrieve or Could not Authenticate"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAddCategoryModal() {
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
                              "Add Category",
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
                          child: Form(
                            key: _keyOne,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ETTextField(
                                    hintText: "Category name",
                                    onSaved: (value) {
                                      setState(() {
                                        state(() {
                                          categoryName = value;
                                        });
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                    SizedBox(),
                                    IconButton(
                                      onPressed: () {
                                        _keyOne.currentState?.save();
                                        db.collection("category").add({
                                          "name": categoryName
                                        }).then((DocumentReference doc) => print(
                                            'DocumentSnapshot added with ID: ${doc.id}'));
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.done),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  _showEditCategoryModal(ExpenseCategory e) {
    return showDialog(
      context: context,
      builder: (context) {
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
                          "Edit Category",
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ETTextField(
                              hintText: "Category name",
                              initialValue: e.name,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close),
                              ),
                              SizedBox(),
                              IconButton(
                                onPressed: () {
                                  // TODO: _doSometing
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.done),
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
  }
}
