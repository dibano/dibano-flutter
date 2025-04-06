import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/workstep_summary.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/track_worksteps.dart';
import 'package:dibano/ui/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseModel.dbHandler = DatabaseHandler();
  //await deleteDatabase(join(await getDatabasesPath(), 'dibano_db'));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FieldsViewModel()),
        ChangeNotifierProvider(create: (context) => CropsViewModel()),
        ChangeNotifierProvider(create: (context) => TrackWorkstepsViewModel()),
        ChangeNotifierProvider(create: (context) => PersonViewModel()),
        ChangeNotifierProvider(create: (context) => ActivitiesViewModel()),
        ChangeNotifierProvider(create: (context) => WorkstepSummaryViewModel()),
      ],
      child: Dibano(),
    ),
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
          seedColor: const Color.fromARGB(255, 66, 129, 4),
        ),
      ),
      home: HomeScreen(title: 'Home'),
    );
  }
}
