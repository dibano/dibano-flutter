import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            CustomTitle(text: 'Beispieltext'),
            Text(
              "Dies ist ein Beispieltext für Ihre Informationsseite. Hier können Sie wichtige Details und Neuigkeiten zu Ihrem Projekt oder Unternehmen einfügen. Passen Sie diesen Text nach Ihren Bedürfnissen an und fügen Sie relevante Informationen hinzu, um Ihre Nutzer auf dem Laufenden zu halten.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
