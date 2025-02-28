import 'package:dibano/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Dibano());
}

class Dibano extends StatelessWidget {
  const Dibano({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}
