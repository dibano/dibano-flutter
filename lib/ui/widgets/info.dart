import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/info_detail.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              "Auf dieser Seite finden Sie allgemeine Informationen zum Bund, zu den Schnittestellen und zu Dibano",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            CustomTitle(text: 'Schnittstellen'),
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
            SizedBox(height: 16),
            CustomTitle(text: 'Bund'),
            DetailCard(
              detail: Detail(
                name: "Informationen zum Bund",
                routeWidget: InfoDetail(title: title),
                isInfo: true,
              ),
            ),
            SizedBox(height: 16),
            CustomTitle(text: 'DIBANO'),
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
