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
              "Auf dieser Seite finden Sie allgemeine Informationen zur App, zu den Schnittstellen und zu Dibano. \n\nVersion 2.2.1",
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
                          text:"1. Deinen Bauernhof einrichten \n Wechsle ins Hauptmenü und tippe auf \"Mein Bauernhof\". \n Dort kannst du alle Stammdaten verwalten: \n - Felder \n - Kulturen \n - Personen \n - Düngemittel \n - Aktivitäten \n\n Beginne damit, deine Felder hinzuzufügen. Danach folgen Kulturen, Personen und alle weiteren relevanten Informationen. \n Sobald alles eingerichtet ist, kehre zurück ins Hauptmenü. \n\n 2. Tätigkeiten dokumentieren \n Gehe auf \"Tätigkeiten dokumentieren\". \n Wähle ein Feld und ein Datum aus. Die passende Kultur wird automatisch erfasst. \n Wähle anschliessend die Tätigkeit und ergänze die relevanten Informationen. \n Speichere deine Eingabe. \n\n 3. Tätigkeiten ansehen und exportieren \n Gehe auf \"Meine Tätigkeiten\". \n Hier findest du alle erfassten Einträge übersichtlich dargestellt. \n Filtere nach Feld, Datum, Kultur, Tätigkeit oder Text \n Anschliessend kannst du ein PDF Exportieren. Du kannst das PDF lokal auf deinem Gerät speichern und jederzeit neu öffnen. \n\n 4. Datensicherung durchführen \n Um deine Daten bei einem Geräteverlust zu schützen, kannst du manuell ein Backup erstellen. \n Tippe dazu im Hauptmenü oben rechts auf das Zahnrad-Symbol (Einstellungen) und wähle \"Backupt erstellen\". \n Deine Daten kannst du dann auf deinem Google Drive Konto speichern und können bei bedarf wiederhergestellt werden. Für die Datenhaltung im Google Drive Konto ist der User oder die Userin selbst verantwortlich.",
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
