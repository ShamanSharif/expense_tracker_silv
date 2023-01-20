import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/view/viewmodel/et_text_field.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final db = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<ExpenseCategory> expenseCategories = [];
  ExpenseCategory? selectedExpenseCategory;
  int? amount;
  int? quantity;
  String? name;
  String? dateTime;
  String? note;

  @override
  void initState() {
    _fetchExpenseCategories();
    super.initState();
  }

  _fetchExpenseCategories() async {
    var categoryRaw = await db.collection("category").get();
    for (var category in categoryRaw.docs) {
      ExpenseCategory e = ExpenseCategory(
        docId: category.id,
        name: category.get("name"),
        alotted: category.get("alottedAmount"),
        spent: category.get("spentAmount"),
        remains: category.get("alottedAmount") - category.get("spentAmount"),
      );
      expenseCategories.add(e);
    }
    setState(() {});
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
        title: Text("Add Expense"),
        actions: [
          IconButton(
            onPressed: () async {
              _formKey.currentState?.save();
              if (amount == null ||
                  selectedExpenseCategory == null ||
                  name == null ||
                  dateTime == null ||
                  quantity == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill all the fields"),
                  ),
                );
                return;
              }
              if (amount! <= selectedExpenseCategory!.remains) {
                await db
                    .collection("category")
                    .doc(selectedExpenseCategory!.docId)
                    .collection("expenses")
                    .add({
                  "name": name,
                  "amount": amount,
                  "quantity": quantity,
                  "dateTime": dateTime,
                  "note": note,
                });
                await db
                    .collection("category")
                    .doc(selectedExpenseCategory!.docId)
                    .update({
                  "spentAmount": selectedExpenseCategory!.spent + amount!,
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Fund is low"),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: expenseCategories.isNotEmpty
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: ETTextField(
                          hintText: "Amount",
                          onSaved: (val) {
                            setState(() {
                              amount = int.tryParse(val ?? "");
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: DropdownSearch<ExpenseCategory>(
                          mode: Mode.MENU,
                          items: expenseCategories,
                          hint: "Category",
                          onChanged: (e) {
                            setState(() {
                              selectedExpenseCategory = e;
                            });
                          },
                          selectedItem: selectedExpenseCategory,
                          dropdownSearchDecoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD1D1D1), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFD1D1D1), width: 2.0),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            // isCollapsed: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: ETTextField(
                          hintText: "Name",
                          onSaved: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: ETTextField(
                          hintText: "Quantity",
                          onSaved: (val) {
                            setState(() {
                              quantity = int.tryParse(val ?? "1");
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: ETTextField(
                          hintText: "Date Time",
                          onSaved: (val) {
                            setState(() {
                              dateTime = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: ETTextField(
                          hintText: "Note (Optional)",
                          onSaved: (val) {
                            setState(() {
                              note = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
