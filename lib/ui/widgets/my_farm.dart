import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/fields.dart';
import 'package:dibano/ui/widgets/crops.dart';

class MyFarm extends StatelessWidget {
  const MyFarm({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24), // Abstand zwischen den Buttons
            Text(
              "Auf dieser Seite können alle Daten des Bauenhofes konfiguriert werden. \nDie Daten bleiben lokal auf dem Gerät gespeichert und gelangen nicht an Drittpersonen.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            CustomTitle(text: 'Daten überarbeiten'),
            DetailCard(
              detail: Detail(
                name: "Felder konfigurieren",
                routeWidget: Fields(title: title),
              ),
            ),
            DetailCard(detail: Detail(name: "Personen konfigurieren")),
            DetailCard(
              detail: Detail(
                name: "Kulturen konfigurieren",
                routeWidget: Crops(title: title),
              ),
            ),
            DetailCard(detail: Detail(name: "Dieses Gerät konfigurieren")),
          ],
        ),
      ),
    );
  }
}
