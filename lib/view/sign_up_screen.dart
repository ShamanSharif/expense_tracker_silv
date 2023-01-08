import 'package:expense_tracker/view/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _osbcureText = false;
  String? _fullName;
  String? _phoneNumber;
  String? _emailAddress;
  String? _password;
  int? _radioGroupValue;

  _createUser() async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailAddress!,
        password: _password!,
      );
      credential.user?.updateDisplayName(_fullName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
                "Sign Up",
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
                      hintText: "Full Name",
                      onSaved: (value) {
                        setState(() {
                          _fullName = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ETTextField(
                        hintText: "Enter Email",
                        onSaved: (value) {
                          setState(() {
                            _emailAddress = value;
                          });
                        },
                      ),
                    ),
                    ETTextField(
                      hintText: "Enter Phone Number",
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
              ),
              ETButton(
                onPressed: () async {
                  _formKey.currentState?.save();
                  if (_emailAddress != null && _password != null) {
                    await _createUser();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashboardScreen();
                        },
                      ),
                      (route) => false,
                    );
                  }
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
