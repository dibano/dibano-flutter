import 'package:flutter/material.dart';

class CustomButtonLarge extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonLarge({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      ),
    );
  }
}
