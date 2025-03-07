import 'package:flutter/material.dart';

// --- ButtonData-Klasse ---
// Diese Klasse definiert die Datenstruktur für jeden Button auf dem Home Screen.
// Jedes ButtonData-Objekt enthält das Icon, den Titel und den Routennamen.
class ButtonData {
  final IconData icon; // Das Icon des Buttons (z.B. Icons.home)
  final String title; // Der Text des Buttons
  final String routeName; // Der Routenname, zu dem navigiert werden soll

  // Konstruktor für die ButtonData-Klasse.
  ButtonData({
    required this.icon,
    required this.title,
    required this.routeName,
  });
}

// --- HomeScreen-Klasse ---
// Diese Klasse stellt den Home Screen der App dar.
// Hier werden alle visuellen Elemente und die Logik für den Startbildschirm definiert.
class HomeScreen extends StatelessWidget {
  // Konstruktor für den HomeScreen.
  const HomeScreen({super.key});

  // --- Button-Liste: Definition der Button-Daten ---
  // Hier werden die Daten für alle Buttons auf dem Home Screen in einer Liste von ButtonData-Objekten gespeichert.
  static final List<ButtonData> buttonDataList = [
    ButtonData(
      icon: Icons.home_outlined,
      title: 'Mein Bauernhof',
      routeName: '/meinBauernhof',
    ),
    ButtonData(
      icon: Icons.add_task_outlined,
      title: 'Tätigkeit erfassen',
      routeName: '/taetigkeitErfassen',
    ),
    ButtonData(
      icon: Icons.list_alt_outlined,
      title: 'Übersicht der Tätigkeiten',
      routeName: '/uebersichtTaetigkeiten',
    ),
    ButtonData(
      icon: Icons.info_outline,
      title: 'Informationen zum App',
      routeName: '/informationenZumApp',
    ),
  ];

  // --- build-Methode: Aufbau des Home Screens ---
  // Die build-Methode wird aufgerufen, wenn Flutter das Widget neu zeichnen muss.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Erstellt die App Bar
      body: _buildBody(context), // Erstellt den Hauptinhalt
    );
  }

  // --- Hilfsmethoden für den Aufbau ---

  // Methode zum Erstellen der App Bar.
  AppBar _buildAppBar() {
    return AppBar(title: const Text('Home'));
  }

  // Methode zum Erstellen des Hauptinhalts (Body).
  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight; // Prüft, ob das Gerät im Landscape-Modus ist
        final buttonSize = _calculateButtonSize(isLandscape, constraints); // Berechnet die Grösse der Buttons
        return _buildButtonList(buttonSize); //Erstellt die Liste der Buttons
      },
    );
  }

  // Methode zum Berechnen der Button-Größe.
  double _calculateButtonSize(bool isLandscape, BoxConstraints constraints) {
    const padding = 16.0; // Padding zwischen den Buttons
    return isLandscape
        ? constraints.maxWidth / 4 - (padding * 1.5)
        : constraints.maxWidth / 2 - (padding * 1.5);
  }

  // Methode zum Erstellen der Scrollbaren Button Liste
  Widget _buildButtonList(double buttonSize) {
    const padding = 10.0; // Padding für den Button Container
    return SingleChildScrollView( // SingleChildScrollView ermöglicht das Scrollen
      padding: const EdgeInsets.all(padding), // Padding um den gesamten Inhalt
      child: Center( // Zentriert die Buttons
        child: Wrap( // Wrap-Widget ordnet die Buttons an
          spacing: padding, // Horizontaler Abstand
          runSpacing: padding, // Vertikaler Abstand
          alignment: WrapAlignment.center, // Zentriert die Buttons
          children: _createButtons(buttonSize), // Erstellt die Liste der Buttons
        ),
      ),
    );
  }

  // Methode zum erstellen der Buttons
  List<Widget> _createButtons(double buttonSize) {
    return [
      for (final buttonData in buttonDataList) // Schleife durch die Button-Daten
        _createButton(buttonData, buttonSize), // Erstelle jeden Button
    ];
  }

  // Methode zum Erstellen eines einzelnen Buttons
  Widget _createButton(ButtonData buttonData, double buttonSize) {
    const iconSize = 48.0; // Grösse der Icons
    return Builder( // Builder Widget notwendig damit Context verfügbar ist.
      builder: (context) {
      return SizedBox( // SizedBox für die Grösse des Buttons
        width: buttonSize, // Breite des Buttons
        height: buttonSize, // Höhe des Buttons
        child: ElevatedButton( // ElevatedButton für jeden Button
          onPressed: () => Navigator.pushNamed(context, buttonData.routeName), // Navigation
          style: ElevatedButton.styleFrom( // Styling des Buttons
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Abgerundete Ecken
            padding: const EdgeInsets.all(20.0), // Padding innerhalb des Buttons
          ),
          child: Column( // Spalte für Icon und Text
            mainAxisAlignment: MainAxisAlignment.center, // Zentriert Icon und Text
            children: [
              Icon(buttonData.icon, size: iconSize), // Icon des Buttons
              const SizedBox(height: 8), // Abstand
              Text(buttonData.title, textAlign: TextAlign.center), // Text des Buttons
            ],
          ),
        ),
      );
    });
  }
}
