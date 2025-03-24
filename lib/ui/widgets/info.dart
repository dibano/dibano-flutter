import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/info_detail.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.title});

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
            "Auf dieser Seite finden Sie allgemeine Informationen zum Bund, zu den Schnittstellen und zu Dibano.",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Schließt den Dialog
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
        onInfoPressed: () => _showInfoDialog(context), // Info-Dialog anzeigen
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            const CustomTitle(text: 'Schnittstellen'),
            DetailCard(
              detail: Detail(
                name: "AGATE",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            DetailCard(
              detail: Detail(
                name: "Bundesamt für Landwirtschaft",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            DetailCard(
              detail: Detail(
                name: "GIS",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            DetailCard(
              detail: Detail(
                name: "HODUFLU",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            const SizedBox(height: 16),
            const CustomTitle(text: 'Bund'),
            DetailCard(
              detail: Detail(
                name: "Informationen zum Bund",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            const SizedBox(height: 16),
            const CustomTitle(text: 'DIBANO'),
            DetailCard(
              detail: Detail(
                name: "Über uns",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
