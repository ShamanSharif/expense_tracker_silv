import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/model/validator_classes.dart';
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
  String? quantity;
  String? name;
  DateTime? dateTime;
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

  _showDatePicker() async {
    dateTime = await showDatePicker(
      context: context,
      initialDate: dateTime ?? DateTime.now(),
      firstDate: DateTime.utc(2020),
      lastDate: DateTime.utc(2050),
      currentDate: dateTime,
    );
    setState(() {});
    print(dateTime);
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
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState?.save();
              if (selectedExpenseCategory == null || dateTime == null) {
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
                  "dateTime": dateTime!.showDateFormatted(),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid amount";
                            }
                            if (int.tryParse(value) == null) {
                              return "Amount should be integer";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid quantity";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              quantity = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            _showDatePicker();
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Color(0xFFD1D1D1),
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 0.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  dateTime == null
                                      ? 'Open Date Picker'
                                      : dateTime!.showDateFormatted(),
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: dateTime == null
                                        ? Colors.grey.shade700
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
