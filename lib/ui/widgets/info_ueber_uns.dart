import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDetailUeberUns extends StatelessWidget {
  const InfoDetailUeberUns({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Wir sind ein Team aus vier engagierten Bachelorstudierenden der Hochschule Luzern im Modul „Integrales Informatik Praxisprojekt“ (IIP) des Departements Informatik. \n\nUnser gemeinsames Ziel ist es, eine praxisnahe und zukunftsfähige Lösung für aktuelle Herausforderungen in der Landwirtschaft zu entwickeln. Mit unserer Plattform wollen wir Landwirtinnen und Landwirten den Alltag erleichtern – durch eine digitale Anwendung, die nicht nur Prozesse vereinfacht, sondern auch Nachhaltigkeit und Effizienz in der Landwirtschaft fördert. \n\nUnsere Vision ist es, die Landwirtschaft durch innovative Technologien zu unterstützen und eine Plattform zu schaffen, die echten Mehrwert bietet – einfach, verständlich und zuverlässig.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FarmColors.darkGreenIntense,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
                onPressed: () {
                  launchUrl(Uri.parse("mailto:dibano.app@gmail.com"));
                },
                child: Text(
                  "Kontaktieren Sie uns!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
