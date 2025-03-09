import 'package:dibano/ui/widgets/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Dibano());
}

class Dibano extends StatelessWidget {
  const Dibano({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIBANO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 69, 132, 7),
        ),
      ),
      home: HomeScreen(title: 'Home'),
    );
  }
}
