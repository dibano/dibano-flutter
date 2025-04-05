import 'package:dibano/ui/view_model/button_data.dart';
import 'package:dibano/ui/view_model/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.title});
  final String title;
  final HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildBody(context),
            _buildFullWidthButton(context, "Meine Tätigkeiten"),
            _buildFullWidthButton(context, "Tätigkeiten erfassen"),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final buttonSize = _calculateButtonSize(isLandscape, constraints);
        return _buildButtonList(buttonSize);
      },
    );
  }

  // Methode zum Berechnen der Button-Größe.
  double _calculateButtonSize(bool isLandscape, BoxConstraints constraints) {
    const padding = 16.0;
    return isLandscape
        ? constraints.maxWidth / 4 - (padding * 1.5)
        : constraints.maxWidth / 2 - (padding * 1.5);
  }

  // Methode zum Erstellen der scrollbaren Button-Liste
  Widget _buildButtonList(double buttonSize) {
    const padding = 16.0;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Wrap(
        spacing: padding,
        runSpacing: padding,
        alignment: WrapAlignment.center,
        children: _createButtons(buttonSize),
      ),
    );
  }

  // Methode zum Erstellen der Buttons
  List<Widget> _createButtons(double buttonSize) {
    final buttonDataList = viewModel.getButtonDataList();
    return [
      for (final buttonData in buttonDataList)
        if (buttonData.title != "Tätigkeiten erfassen" &&
            buttonData.title != "Meine Tätigkeiten")
          _createButton(buttonData, buttonSize),
    ];
  }

  // Methode zum Erstellen eines einzelnen Buttons
  Widget _createButton(ButtonData buttonData, double buttonSize) {
    const iconSize = 48.0;
    return Builder(
      builder: (context) {
        return SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buttonData.routeWidget),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: buttonData.color,
              padding: const EdgeInsets.all(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(buttonData.icon, size: iconSize),
                const SizedBox(height: 8),
                Text(buttonData.title, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullWidthButton(BuildContext context, String title) {
    const padding = 16.0;
    final buttonData = viewModel.getButtonDataList().firstWhere(
      (data) => data.title == title,
    );

    return Padding(
      padding: const EdgeInsets.all(padding),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttonData.routeWidget),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: buttonData.color,
            padding: const EdgeInsets.all(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(buttonData.icon, size: 48), // Icon hinzufügen
              const SizedBox(height: 8),
              Text(buttonData.title),
            ],
          ),
        ),
      ),
    );
  }
}
