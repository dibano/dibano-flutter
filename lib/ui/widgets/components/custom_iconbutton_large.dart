import 'package:flutter/material.dart';

class CustomIconButtonLarge extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const CustomIconButtonLarge({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}