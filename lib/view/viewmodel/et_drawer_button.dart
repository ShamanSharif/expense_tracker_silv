import 'package:flutter/material.dart';

class ETDrawerButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final IconData iconData;
  const ETDrawerButton({
    super.key,
    required this.label,
    required this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                iconData,
                color: Color(0xFF1EA0CD),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
