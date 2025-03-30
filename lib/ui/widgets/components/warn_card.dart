import 'package:flutter/material.dart';

class Warn extends StatelessWidget {
  const Warn({super.key, required this.warnText});

  final String warnText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(warnText, style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
