import 'package:expense_tracker/view/dashboard_screen.dart';
import 'package:expense_tracker/view/forgot_password_screen.dart';
import 'package:expense_tracker/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'viewmodel/et_button.dart';
import 'viewmodel/et_text_button.dart';
import 'viewmodel/et_text_field.dart';

class ForgotPasswordNewPasswordScreen extends StatefulWidget {
  const ForgotPasswordNewPasswordScreen({super.key});

  @override
  State<ForgotPasswordNewPasswordScreen> createState() =>
      _ForgotPasswordNewPasswordScreenState();
}

class _ForgotPasswordNewPasswordScreenState
    extends State<ForgotPasswordNewPasswordScreen> {
  bool _osbcureText = false;

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
                "New Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  ETTextField(
                    hintText: "Enter new password",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ETTextField(
                      hintText: "Confirm new password",
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ETButton(
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
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF56ACC4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
