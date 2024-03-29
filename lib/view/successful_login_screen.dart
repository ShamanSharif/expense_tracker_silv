import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/view/dashboard_screen.dart';
import 'package:expense_tracker/view/dashboard_screen_stuff.dart';
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

  String userID = "";
  var userData;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userID = user.uid;
          _getUserGroup();
        });
      }
    });
  }

  Future<void> _getUserGroup() async {
    final ud = await db.collection("user_data").doc(userID).get();
    setState(() {
      userData = ud;
    });
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
              "Hello ${userData?["name"] ?? ""}",
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
              child: userData == null
                  ? Center(child: CircularProgressIndicator())
                  : ETButton(
                      onPressed: () async {
                        int group = userData["group"];
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
                          case 3:
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DashboardStuffScreen();
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
