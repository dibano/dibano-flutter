import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/track_activities.dart';
import 'package:dibano/ui/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (context) => FieldsViewModel()
        ),
        ChangeNotifierProvider(
          create: (context) => TrackActivetiesViewModel()
        ),
      ],
      child: Dibano()
    )
  );
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
