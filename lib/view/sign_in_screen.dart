import 'package:expense_tracker/view/forgot_password_screen.dart';
import 'package:expense_tracker/view/successful_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';
import 'viewmodel/et_button.dart';
import 'viewmodel/et_text_button.dart';
import 'viewmodel/et_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _osbcureText = false;
  String? _emailAddress;
  String? _password;

  _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailAddress!,
        password: _password!,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SuccessfulLoginScreen();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

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
                "Sign In",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ETTextField(
                      hintText: "Enter email",
                      onSaved: (value) {
                        setState(() {
                          _emailAddress = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ETTextField(
                        hintText: "Enter Password",
                        onSaved: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
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
                    ETTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPasswordScreen();
                            },
                          ),
                        );
                      },
                      child: Text("Forgot Password?"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ETButton(
                  onPressed: () async {
                    _formKey.currentState?.save();
                    if (_emailAddress == null || _password == null) {
                      return;
                    }
                    await _signIn();
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
