import 'package:expense_tracker/view/dashboard_screen.dart';
import 'package:expense_tracker/view/forgot_password_code_screen.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';
import 'viewmodel/et_button.dart';
import 'viewmodel/et_text_button.dart';
import 'viewmodel/et_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                "Forgot Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  ETTextField(
                    hintText: "Enter your email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "If you have an account accociated with your email address. We will send you an email on that address with a one time code to reset your password.",
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
                          return const ForgotPasswordCodeScreen();
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
                        return SignUpScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
