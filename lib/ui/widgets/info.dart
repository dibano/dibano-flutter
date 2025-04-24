import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/info_detail.dart';
import 'package:dibano/ui/widgets/info_ueber_uns.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.title});

  final String title;

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          alertText:
              "Auf dieser Seite finden Sie allgemeine Informationen zur App, zu den Schnittstellen und zu Dibano.",
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            const CustomTitle(text: 'Anleitung'),
            DetailCard(
              detail: Detail(name: "Vorgehen", isInfo: true),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => InfoDetail(
                          title: "Vorgehen",
                          text:
                              "Beginnen Sie damit, Ihren Bauernhof digital zu erfassen. \n\nAls Erstes müssen Sie im Menüpunkt „Mein Bauernhof“ Ihre Felder, Kulturen und Personen erfassen. \n\nWenn Sie die Informationen eingetragen haben, können Sie unter „Tätigkeiten erfassen“ Ihre erledigten Arbeiten dokumentieren. \n\nDiese werden lokal auf Ihrem Handy gespeichert und können unter „Meine Tätigkeiten“ eingesehen werden. Dort können Sie Ihre Daten auch filtern und anschliessend als PDF exportieren. \n\nWenn Sie Ihre Arbeiten in einer Cloud speichern möchten, zum Beispiel bei einem Verlust des Handys, können Sie dies über das Einstellungsrad oben rechts im Hauptmenü aktivieren. Ihre Daten werden dann auf Google Drive hochgeladen und können jederzeit wiederhergestellt werden.",
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            const CustomTitle(text: 'Schnittstellen'),
            DetailCard(
              detail: Detail(name: "map.geo.admin", isInfo: true),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => InfoDetail(
                          title: "map.geo.admin",
                          text:
                              "Der Nutzer kann ein Feld auf einer Karte von OpenStreetMap auswählen und stellt eine Anfrage über eine REST-API an das Geoportal des Bundes (geo.admin.ch), um Informationen über das betreffende Feld abzurufen. Dies ermöglicht präzise Daten zur Feldgrösse.",
                        ),
                  ),
                );
              },
            ),
            DetailCard(
              detail: Detail(name: "OpenStreetMap.org", isInfo: true),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => InfoDetail(
                          title: "OpenStreetMap.org",
                          text:
                              "OpenStreetMap wird in der App als Kartenbasis genutzt, um eigene Felder einfach und übersichtlich in Kombination mit GIS hinzuzufügen. \n\nSo lassen sich Flächen dem digitalen Bauernhof hinzufügen und geografisch korrekt zuordnen. Die Karte bietet eine klare Darstellung von Wegen, Feldern und Gelände und unterstützt die visuelle Erfassung der Betriebsflächen.",
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const CustomTitle(text: 'DIBANO'),
            DetailCard(
              detail: Detail(name: "Über uns", isInfo: true),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoDetailUeberUns(title: "Über uns"),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const CustomTitle(text: 'Datenschutz'),
            DetailCard(
              detail: Detail(
                name: "Wie werden deine Daten geschützt?",
                isInfo: true,
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => InfoDetail(
                          title: "Datenschutz",
                          text:
                              "Alle Daten werden lokal auf dem eigenen Handy gespeichert. Sie bleiben somit vollständig unter der Kontrolle der Nutzerin oder des Nutzers. Optional kann freiwillig ein Backup über Google Drive erstellt werden. Die Funktionen zum Erstellen eines Backups und dem Wiederherstellen von gespeicherten Daten findet man über das Einstellungssymbol auf der Startseite. \n\nDibano übernimmt keine Verantwortung für die Daten in den Google-Drive-Verzeichnissen der Nutzerinnen und Nutzer. Aus der lokalen Sicherung auf den Smartphones kann Dibano weder auf Daten zugreifen noch diese wiederherstellen. Die App gibt keine Daten ohne Zustimmung der Nutzerin oder des Nutzers an Dritte weiter. Der Schutz und die Sicherheit der Daten haben höchste Priorität.",
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
