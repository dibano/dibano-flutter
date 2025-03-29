import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/view_model/components/farm_box.dart';
import 'package:dibano/ui/widgets/acitivities.dart';
import 'package:dibano/ui/widgets/components/farm_boxes.dart';
import 'package:dibano/ui/widgets/people.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/fields.dart';
import 'package:dibano/ui/widgets/crops.dart';

class MyFarm extends StatelessWidget {
  const MyFarm({super.key, required this.title});

  final String title;

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.info,
            color: Colors.green, // Icon-Farbe auf Grün setzen
          ),
          content: const Text(
            "Auf dieser Seite können alle Daten des Bauernhofes konfiguriert werden. \nDie Daten bleiben lokal auf dem Gerät gespeichert und gelangen nicht an Drittpersonen.",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        hasInfo: true,
        onInfoPressed: () => _showInfoDialog(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: FarmBox(
                      box: FarmContent(
                        icon: Icons.grass,
                        title: "Meine Felder",
                        routeWidget: Fields(title: "Meine Felder"),
                        color: const Color.fromARGB(255, 205, 231, 176),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FarmBox(
                      box: FarmContent(
                        icon: Icons.person,
                        title: "Meine Mitarbeiter",
                        routeWidget: People(title: "Meine Mitarbeiter"),
                        color: const Color.fromARGB(255, 230, 214, 187),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: FarmBox(
                      box: FarmContent(
                        icon: Icons.eco,
                        title: "Meine Kulturen",
                        routeWidget: Crops(title: "Meine Kulturen"),
                        color: const Color.fromARGB(255, 198, 229, 255),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FarmBox(
                      box: FarmContent(
                        icon: Icons.agriculture,
                        title: "Meine Aktivitäten",
                        routeWidget: Activities(title: "Meine Aktivitäten"),
                        color: const Color.fromARGB(255, 255, 245, 200),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: FarmBox(
                      box: FarmContent(
                        icon: Icons.settings,
                        title: "Dieses Gerät konfigurieren",
                        color: const Color.fromARGB(255, 230, 214, 187),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
