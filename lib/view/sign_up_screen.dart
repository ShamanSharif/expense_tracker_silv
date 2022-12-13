import 'package:expense_tracker/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'viewmodel/et_button.dart';
import 'viewmodel/et_text_button.dart';
import 'viewmodel/et_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _osbcureText = false;
  int? _radioGroupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  ETTextField(
                    hintText: "Full Name",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ETTextField(
                      hintText: "Enter Email",
                    ),
                  ),
                  ETTextField(
                    hintText: "Enter Phone Number",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ETTextField(
                      hintText: "Enter Password",
                      osbcureText: _osbcureText,
                      suffixIcon: IconButton(
                        icon: _osbcureText
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _osbcureText = !_osbcureText;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _radioGroupValue,
                            onChanged: (value) {
                              setState(() => _radioGroupValue = value);
                            },
                          ),
                          Text("Student"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _radioGroupValue,
                            onChanged: (value) {
                              setState(() => _radioGroupValue = value);
                            },
                          ),
                          Text("Teacher"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: _radioGroupValue,
                            onChanged: (value) {
                              setState(() => _radioGroupValue = value);
                            },
                          ),
                          Text("Stuff"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ETButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DashboardScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xFF56ACC4),
              ),
              ETTextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignInScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text("Already have an account? Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
