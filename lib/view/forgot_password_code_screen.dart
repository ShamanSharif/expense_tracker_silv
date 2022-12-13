import 'package:expense_tracker/view/dashboard_screen.dart';
import 'package:expense_tracker/view/forgot_password_new_password.dart';
import 'package:expense_tracker/view/forgot_password_screen.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';
import 'viewmodel/et_button.dart';
import 'viewmodel/et_text_button.dart';
import 'viewmodel/et_text_field.dart';

class ForgotPasswordCodeScreen extends StatefulWidget {
  const ForgotPasswordCodeScreen({super.key});

  @override
  State<ForgotPasswordCodeScreen> createState() =>
      _ForgotPasswordCodeScreenState();
}

class _ForgotPasswordCodeScreenState extends State<ForgotPasswordCodeScreen> {
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
                "Enter OTP",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  ETTextField(
                    hintText: "Enter one time password from email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your one time password from your email inbox. If you don't see an email, please wait about 5 minutes and also check the spam folder.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
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
                          return ForgotPasswordNewPasswordScreen();
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
              ETTextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text("Recheck email address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
