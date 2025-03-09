import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/corps_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/view_model/crops.dart';

class Crops extends StatelessWidget {
  const Crops({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    CropsViewModel crops = new CropsViewModel();

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 24),
                    CustomTitle(text: 'Kulturen konfigurieren'),
                    for (var crop in crops.getCrops())
                      DetailCard(
                        detail: Detail(
                          name: crop.field,
                          description: crop.crop,
                          routeWidget: CorpsEdit(), //to do: add route
                        ),
                      ),
                  ],
                ),
              ),
            ),
            CustomButtonLarge(
              text: 'Kulturen hinzufügen',
              onPressed: () {
                // To do: Handle button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
