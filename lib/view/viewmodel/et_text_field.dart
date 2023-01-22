import 'package:flutter/material.dart';

class ETTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool osbcureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const ETTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.osbcureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: osbcureText,
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
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
