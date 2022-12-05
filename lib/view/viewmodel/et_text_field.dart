import 'package:flutter/material.dart';

class ETTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final bool osbcureText;
  const ETTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.osbcureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: osbcureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 2.0),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
