import 'package:flutter/material.dart';

class ETTextField extends StatelessWidget {
  final String? hintText;
  const ETTextField({
    super.key,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: new InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 2.0),
        ),
        hintText: hintText,
      ),
    );
  }
}
