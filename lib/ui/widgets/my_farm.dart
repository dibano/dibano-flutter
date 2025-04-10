import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/view_model/components/farm_box.dart';
import 'package:dibano/ui/widgets/acitivities.dart';
import 'package:dibano/ui/widgets/components/farm_boxes.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
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
        return CustomAlertDialog(
          alertText:
              "Auf dieser Seite können alle Daten des Bauernhofes konfiguriert werden. \nDie Daten bleiben lokal auf dem Gerät gespeichert und gelangen nicht an Drittpersonen.",
          alertType: AlertType.info,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FarmBox(
              box: FarmContent(
                icon: Icons.person,
                title: "Meine Mitarbeiter",
                routeWidget: People(title: "Meine Mitarbeiter"),
                color: FarmColors.grassGreen,
              ),
            ),
            const SizedBox(height: 8),
            FarmBox(
              box: FarmContent(
                icon: Icons.agriculture,
                title: "Meine Aktivitäten",
                routeWidget: Activities(title: "Meine Aktivitäten"),
                color: FarmColors.grassGreen,
              ),
            ),
            const SizedBox(height: 8),
            FarmBox(
              box: FarmContent(
                icon: Icons.eco,
                title: "Meine Kulturen",
                routeWidget: Crops(title: "Meine Kulturen"),
                color: FarmColors.grassGreen,
              ),
            ),
            const SizedBox(height: 8),
            FarmBox(
              box: FarmContent(
                icon: Icons.grass,
                title: "Meine Felder",
                routeWidget: Fields(title: "Meine Felder"),
                color: FarmColors.grassGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
