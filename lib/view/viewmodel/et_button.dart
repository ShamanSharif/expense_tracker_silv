import 'package:flutter/material.dart';

class ETButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  const ETButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: child,
      height: 50,
      color: color ?? Color(0xFF85A0CA),
    );
  }
}
