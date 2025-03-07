import 'package:dibano/home.dart';
import 'package:dibano/track_activities.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 69, 132, 7)),
      ),
      home: const TrackActivities(title: 'Tätigkeit erfassen'),
    );
  }
}
