import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/view/dashboard_screen.dart';
import 'package:expense_tracker/view/dashboard_student_screen.dart';
import 'package:expense_tracker/view/viewmodel/et_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessfulLoginScreen extends StatefulWidget {
  const SuccessfulLoginScreen({super.key});

  @override
  State<SuccessfulLoginScreen> createState() => _SuccessfulLoginScreenState();
}

class _SuccessfulLoginScreenState extends State<SuccessfulLoginScreen> {
  final db = FirebaseFirestore.instance;
  String username = "";
  String userID = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          username = user.displayName ?? "";
          userID = user.uid;
        });
      }
    });
  }

  Future<int> _getUserGroup() async {
    final userData = await db.collection("user_data").doc(userID).get();
    return userData["group"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8FAF2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration,
              size: 96,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hello $username",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "You've successfully logged in",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ETButton(
                onPressed: () async {
                  int group = await _getUserGroup();

                  switch (group) {
                    case 1:
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardStudentScreen();
                          },
                        ),
                        (route) => false,
                      );
                      break;
                    case 2:
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardScreen();
                          },
                        ),
                        (route) => false,
                      );
                      break;
                    default:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Something went wrong"),
                        ),
                      );
                  }
                },
                child: Text(
                  "Go To Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
